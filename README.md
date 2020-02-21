# TouchscreenTaps

TouchscreenTaps is a touchscreen taps recognizer. It allows "tap and hold" gesture to be recognized and assign a command to it.

# Instalation

```bash
sudo gpasswd -a $USER input
sudo apt install libinput-tools
sudo apt install xdotool
sudo apt install ruby
sudo gem install touchscreen-taps
```

# Usage
```bash
touchscreen-taps
```
Pass custom config 
```bash
touchscreen-taps /home/user/custom_config.yml
```

# Config example
```yaml
---
tap_and_hold: # event name
  1: # fingers count
    command: 'xdotool click 3'
    acceptance_delay: '0.5' # seconds
```
# Run as daemon
```bash
touchscreen-taps &
```

# Autostart
```bash
echo 'touchscreen-taps &' | sudo tee /etc/profile.d/start-touchscreen-taps.sh
```

# Tested on:
Surface Pro 3 (i5/8gb/256gb)
Ubuntu 18.04 LTS (linux 5.5, Gnome, Xorg)


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
