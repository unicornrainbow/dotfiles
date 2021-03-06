#!/bin/zsh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# General
## Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
## Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
## Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
## Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
## Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true
## Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
## Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
## Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
## Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
## Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
## Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "ru" "de"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
## Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
## Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"
## Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
## Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Finder
## Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
## Allow selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
## Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
## When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
## Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
## Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
## Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0
## Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
## Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true
## Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
## Show the ~/Library folder
chflags nohidden ~/Library

# Mail
## Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Stuff
## Enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true
## Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
## Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
## Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true
## Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
## Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true
