# Syncthing policy example

The public snapshot documents selection policy rather than device IDs or real
folder paths.

| Folder class | Direction | Versioning |
| --- | --- | --- |
| Active notes and documents | Two-way between trusted workstations | Enabled |
| Generated build output | Not synchronized | Not applicable |
| Secret-manager state | Not synchronized through this layer | Owned elsewhere |
| Historical recovery | Not a Syncthing responsibility | Restic-owned |

New devices are enrolled explicitly. A replacement device receives a new
identity instead of inheriting the old machine's private key or device record.
