#!/usr/bin/env python2
import os
from datetime import datetime
import web
from phue import Bridge

# This "authentication" is so weak that I'm not bothering to protect it at all.
# Until Phillips implements something worthwhile, authentication should be handled by routing. =\
hue_username = 'mister-owl'

class ApplicationCustomPort(web.application):
	def run(self, port=8080, *middleware):
		func = self.wsgifunc(*middleware)
		return web.httpserver.runsimple(func, ('0.0.0.0', port))

def hue_init(hue_username):
	import urllib2
	import json
	hue_info = urllib2.urlopen('https://www.meethue.com/api/nupnp').read()
	try:
		hue_ip = json.loads(hue_info)[0]['internalipaddress']
	except IndexError:
		# Bridge has had trouble pinging API due to ISP outage
		hue_ip = '192.168.1.70'
	return Bridge(hue_ip, hue_username)

hue_state = {
	'is_locked': False,
	'current_preset': None,
}
class BedroomHue:
	lights_all = ('Lamp', 'Ceiling E', 'Ceiling W')
	lights_lamp = ('Lamp',)
	lights_ceiling = ('Ceiling E', 'Ceiling W')

	def __init__(self):
		self.bridge = hue_init(hue_username)
		global hue_state
		self.state = hue_state

		# route: [relative_brightness, method]
		# We use brightness to determine when it's acceptable to change presets
		self.presets = {
			'off':       [  0, self.preset_off],
			'lamp':      [ 10, self.preset_lamp],
			'dim':       [ 50, self.preset_dim],
			'bright':    [100, self.preset_bright],
			'gaming':    [ 30, self.preset_gaming],
			'moonlight': [ 40, self.preset_moonlight],
		}

	def _set_light(self, lights, command, transitiontime=None):
		if transitiontime is not None:
			command['transitiontime'] = transitiontime
		self.bridge.set_light(lights, command)

	def GET(self, path):
		if path == 'lock':
			if self.state['is_locked']:
				return '1'
			else:
				return '0'
		return 'Invalid preset "%s"' % path

	def POST(self, path):
		if path == 'lock/on':
			self.state['is_locked'] = True
			return 'Lights locked.'
		elif path == 'lock/off':
			self.state['is_locked'] = False
			return 'Lights unlocked.'

		if path not in self.presets:
			return 'Invalid preset "%s"' % path
		preset_name = path

		# Determine force input
		force = False
		try:
			if web.input().force == '1':
				force = True
		except:
			force = False

		# Determine transition input
		try:
			transition = web.input().transition
			transition = int(10 * float(transition)) # To deciseconds
		except:
			transition = None

		(brightness, preset_method) = self.presets[preset_name]

		# Disallow non-forced brightening late
		# i.e. Don't begin evening fade if we're already on off/lamp.
		if self.state['current_preset'] is not None and datetime.now().hour >= 20:
			old_brightness = self.presets[self.state['current_preset']][0]
			if brightness > old_brightness and not force:
				return 'Lights may not brighten after 2000'

		if self.state['is_locked'] and not force:
			return 'Lights are locked'

		self.state['current_preset'] = preset_name
		return preset_method(transitiontime=transition)

	def preset_off(self, transitiontime=None):
		command = {'on': False, 'bri': 0}
		self._set_light(self.lights_all, command, transitiontime)
		return 'Success'

	def preset_lamp(self, transitiontime=None):
		ceil_command = {'on': False, 'bri': 0}
		lamp_command = {'on': True, 'bri': 50, 'sat': 93, 'hue': 0}
		self._set_light(self.lights_ceiling, ceil_command) # Turn off immediately
		self._set_light(self.lights_lamp, lamp_command, transitiontime)
		return 'Success'

	def preset_dim(self, transitiontime=None):
		command = {'on': True, 'bri': 128, 'sat': 43, 'hue': 42000}
		self._set_light(self.lights_all, command, transitiontime)
		return 'Success'

	def preset_bright(self, transitiontime=None):
		command = {'on': True, 'bri': 255, 'sat': 0}
		self._set_light(self.lights_all, command, transitiontime)
		return 'Success'

	def preset_gaming(self, transitiontime=None):
		ceil_command = {'on': False, 'bri': 0}
		lamp_command = {'on': True, 'bri': 150, 'sat': 80, 'hue': 0}
		self._set_light(self.lights_ceiling, ceil_command) # Turn off immediately
		self._set_light(self.lights_lamp, lamp_command, transitiontime)
		return 'Success'

	def preset_moonlight(self, transitiontime=None):
		command = {'on': True, 'bri': 38, 'sat': 146, 'hue': 42000}
		self._set_light(self.lights_all, command, transitiontime)
		return 'Success'

class Tricluck:
	def POST(self, path):
		if path == 'dpms/on':
			os.system('DISPLAY=:0 xset dpms force on')
		elif path == 'dpms/off':
			os.system('DISPLAY=:0 xset dpms force off')
		elif path == 'redshift/on':
			os.system('DISPLAY=:0 redshift &')
		elif path == 'redshift/off':
			os.system('pkill redshift')
			os.system('redshift_reset') # Sometimes things weren't properly reset, especially with multiple instances running
		elif path == 'suspend':
			os.system('sudo systemctl suspend')

class TricluckWin:
	def POST(self, path):
		if path == 'dpms/on':
			os.system('dpms_on')
		elif path == 'dpms/off':
			os.system('dpms_off')
		elif path == 'redshift/on':
			pass # FIXME is f.lux scriptable?
		elif path == 'redshift/off':
			pass # FIXME is f.lux scriptable?
		elif path == 'suspend':
			os.system('rundll32.exe powrprof.dll,SetSuspendState 0,1,0')

urls = (
	'/lights/bedroom/(.*)', 'BedroomHue',
	'/tricluck/(.*)', 'TricluckWin',
)
app = ApplicationCustomPort(urls, locals())

if __name__ == '__main__':
	app.run(port=10101)

