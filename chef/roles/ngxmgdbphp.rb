# Name of the role. Must match the name of the file
name 'ngxmgdbphp'

# Override the default settings on a node.
override_attributes(
  'chef_environment' => 'development',
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
    'recipe[cookbook-ngxmgdbphp]'
)
