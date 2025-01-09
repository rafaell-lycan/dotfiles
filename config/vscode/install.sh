# Install VS Code extensions via "code --install-extension <extension-id>"

#----------------------------------------
# core
#----------------------------------------
core_extensions=(
    "string1"
    "string2"
    "string3"
    "string4"
)

for i in core_extensions; do code --install-extension $i; done
#----------------------------------------
# side
#----------------------------------------
side_extensions=(
    "string1"
    "string2"
    "string3"
    "string4"
)
for i in side_extensions; do code --install-extension $i; done
