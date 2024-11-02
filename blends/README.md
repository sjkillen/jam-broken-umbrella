Each .blend file has export.py text block that when run should export the file's corresponding GLB

# Exporting from Blender
- Open file, scripting workspace, run text block named 'export.py'

# Exporting from CLI
- blender --factory-startup -b blends/<NAME OF BLEND FILE>.blend --python-text export.py
