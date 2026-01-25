{
  # collectFiles: Collects all .nix files from a directory for use in imports
  # Usage: imports = lib.collectFiles ./programs;
  collectFiles = dir: let
    # Read the directory contents
    entries = builtins.readDir dir;

    # Get list of filenames
    filenames = builtins.attrNames entries;

    # Filter for .nix files
    nixFiles =
      builtins.filter (
        name:
          builtins.match ".*\\.nix" name != null
      )
      filenames;

    # Map filenames to full paths
    paths = map (name: dir + "/${name}") nixFiles;
  in
    paths;
}
