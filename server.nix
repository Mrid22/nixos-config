{config,pkgs,...}:{
 fileSystems."/media" = {
   device = "/dev/sda1";
   fsType = "ntfs";
   options = [
     "users"
     "nofail"
     
   ];
 };
}
