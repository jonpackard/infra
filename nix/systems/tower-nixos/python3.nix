let
  my-python-packages = p: with p; [
    yaml
    #pandas
    #requests
    # other python packages
  ];
in
environment.systemPackages = {[
  (pkgs.python3.withPackages my-python-packages)
];
};

