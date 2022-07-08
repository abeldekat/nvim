#! /bin/bash

# https://github.com/redhat-developer/yaml-language-server

# YAML validation:
#     Detects whether the entire file is valid yaml
# Validation:
#     Detects errors such as:
#         Node is not found
#         Node has an invalid key node type
#         Node has an invalid type
#         Node is not a valid child node
#     Detects warnings such as:
#         Node is an additional property of parent
# Auto completion:
#     Auto completes on all commands
#     Scalar nodes autocomplete to schema's defaults if they exist
# Hover support:
#     Hovering over a node shows description if available
# Document outlining:
#     Shows a complete document outline of all nodes in the document
_yamlls(){
  echo "dummy"
}

_ansiblels(){
  echo "dummy"
  # -- npm install -g @ansible/ansible-language-server
  echo "ansible: pacman"
  echo "ansiblelint: pacman ansible-lint, also installs yamllint"
}
