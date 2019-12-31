class VolumeControl {
  Dial dial;

  VolumeControl(AudioPlayer[] p, Dial d) {
    files = p;
    dial = d;
  }

  void update() {
    for (AudioPlayer player : files) { 

      if ( player.hasControl(Controller.GAIN) )
      {
        // map the mouse position to the audible range of the gain
        float val = map(dial.getSetting(), dial.max, dial.min, 10, -35);
        // if a gain control is not available, this will do nothing
        player.setGain(val); 
      }
      
    }
  }
  
}
