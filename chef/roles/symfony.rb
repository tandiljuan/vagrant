# Name of the role. Must match the name of the file
name 'symfony'

# Override the default settings on a node.
override_attributes(
  'smbfs' => {
    'install' => false,
    'mounts' => {
      '/dummy/mount/point' => {
        'cifs_path' => '//dummi/cifs/path'
      }
    }
  }
)

# Run list function
run_list(
    'recipe[cookbook-symfony]'
)
