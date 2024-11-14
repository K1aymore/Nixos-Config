{ config, pkgs, ... }:


{

  services.touchegg.enable = true;

  home-manager.users.klaymore.home.file = {
    ".config/touchegg/touchegg.conf".text = ''
      <gesture type="SWIPE" fingers="3" direction="LEFT">
        <action type="SEND_KEYS">
          <repeat>true</repeat>
          <modifiers>Control_L</modifiers>
          <keys>z</keys>
          <decreaseKeys>Shift_L+z</decreaseKeys>
        </action>
      </gesture>

      <gesture type="SWIPE" fingers="3" direction="RIGHT">
        <action type="SEND_KEYS">
          <repeat>true</repeat>
          <modifiers>Control_L</modifiers>
          <keys>Shift_L+z</keys>
          <decreaseKeys>z</decreaseKeys>
        </action>
      </gesture>
    '';
  };
}
