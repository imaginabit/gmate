#!/bin/sh
# Kill all runing instances if exists
# killall gedit

# Try to use sudo
#echo "Type root password if you want to install system wide. Press [Enter] to install to this user only"
#sudo -v

#if [ $(id -u) = "0" ]; then
#  sudo="yes"
#else
  sudo="no"
#fi

# Make it talk
alias mkdir="mkdir -v"
alias cp="cp --verbose --backup  --suffix=.bak"

# Register rails-related mime types
if [ $sudo = "yes" ]; then
  sudo cp mime/*.xml /usr/share/mime/packages
  sudo update-mime-database /usr/share/mime
else
  mkdir -p ~/.local/share/mime/packages
  cp mime/*.xml ~/.local/share/mime/packages
  update-mime-database ~/.local/share/mime
fi

# Copy language definitions
if [ $sudo = "yes" ]; then
  sudo cp lang-specs/*.lang /usr/share/gtksourceview-2.0/language-specs/
else
  mkdir -p ~/.local/share/gtksourceview-2.0/language-specs
  cp lang-specs/* ~/.local/share/gtksourceview-2.0/language-specs/
fi

#if [ $sudo = "yes" ]; then
#  # Copy Gmate executable
#  sudo mkdir -p /usr/share/gedit-2/gmate
#  sudo cp gmate.py /usr/share/gedit-2/gmate/gmate.py
#else
#  mkdir -p ~/.bin/
#  cp gmate.py ~/.bin/gmate
#fi

# Copy Tags
if [ $sudo = "yes" ]; then
  sudo mkdir -p /usr/share/gedit-2/plugins/taglist/
  sudo cp tags/*.tags.gz /usr/share/gedit-2/plugins/taglist/
else
  mkdir -p ~/.gnome2/gedit/taglist/
  cp tags/*.tags.gz ~/.gnome2/gedit/taglist/
fi

# Copy gedit facilities
if [ ! -d $HOME/.gnome2/gedit ]
then
  mkdir -p ~/.gnome2/gedit
fi
# Copy Snippets
if [ ! -d $HOME/.gnome2/gedit/snippets ]
then
  mkdir -p ~/.gnome2/gedit/snippets
fi
cp snippets/* ~/.gnome2/gedit/snippets/

# Copy Plugins
if [ ! -d $HOME/.gnome2/gedit/plugins ]
then
  mkdir -p ~/.gnome2/gedit/plugins
fi
cp -R plugins/* ~/.gnome2/gedit/plugins

# Copy Styles
if [ ! -d $HOME/.gnome2/gedit/styles ]
then
  mkdir -p ~/.gnome2/gedit/styles
fi
cp styles/* ~/.gnome2/gedit/styles

# Ask for Python-Webkit package
if [ -f /etc/debian_version ]; then
  if [ $sudo = "yes" ]; then
    sudo apt-get install python-webkit
  else
    echo "Please install python-webkit (sudo apt-get install python-webkit)"
  fi
fi

# Execute debian postins script
#if [ $sudo = "yes" ]; then
#  `sudo sh ./debian/postinst`
#else
#  `sh ./debian/postinst`
#fi

#echo -n "Do you want to activate default plugin and configuration set? [y,N]:"
#read answer
#case "$answer" in
#    [yY])
#        `gconftool-2 --set /apps/gedit-2/plugins/active-plugins -t list --list-type=str [rails_extract_partial,rubyonrailsloader,align,smart_indent,text_tools,completion,quickhighlightmode,gemini,trailsave,rails_hotkeys,fuzzyopen,filebrowser,snippets,modelines,smartspaces,docinfo,time,spell,terminal,drawspaces,codecomment,colorpicker,indent,encodingpy,FindInProject]`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/auto_indent/auto_indent -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/bracket_matching/bracket_matching -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/current_line/highlight_current_line -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/cursor_position/restore_cursor_position -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/line_numbers/display_line_numbers -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/right_margin/display_right_margin -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/right_margin/right_margin_position -t int 80`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/colors/scheme -t str twilight`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/tabs/insert_spaces -t bool true`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/tabs/tabs_size -t int 4`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/wrap_mode/wrap_mode -t str GTK_WRAP_NONE`
#        `gconftool-2 --set /apps/gedit-2/preferences/editor/save/create_backup_copy -t bool false`
#        echo "Configuration set."
#        ;;
#    *)
#        echo "No config performed."
#        ;;
#esac

