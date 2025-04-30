# Inspired by ~/.osx — http://mths.be/osx

OSX=$(test "`uname`" == "Darwin" && echo "x")

# disable_agent() {
#   mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
#     sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
# }

# unload_agent() {
#   launchctl unload -w "$1" >/dev/null 2>&1
# }

if [[ OSX ]]; then
    # Close System Preferences to prevent override
    osascript -e 'tell application "System Preferences" to quit'

    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # ...
else
    echo "Skipping ~/.osx evaluation..."
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo ""
echo "› System:"

# Menu bar: disable transparency
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true

# Set highlight color to green
# defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# echo "  › Set sidebar icon size to small"
# defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# echo "  › Always show scrollbars"
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# # Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable the over-the-top focus ring animation
# defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Adjust toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Disable smooth scrolling
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ...

# echo "  › Set graphite appearance"
# defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# # echo "  › Set graphite highlight color"
# # defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745"

# echo "  › Show battery percent"
# defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  › Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

echo "  › Set dark interface style"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

echo "  › Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  › Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# echo "  › Enable text replacement almost everywhere"
# defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

echo "  › Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "  › Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "  › Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "  › Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# echo "  › Set up trackpad & mouse speed to a reasonable number"
# defaults write -g com.apple.trackpad.scaling 3
# defaults write -g com.apple.mouse.scaling 3

# echo "  › Avoid the creation of .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Energy saving                                                               #
###############################################################################

echo ""
echo "› Energy saving:"

# echo "  › Enable lid wakeup"
# sudo pmset -a lidwake 1

# echo "  › Restart automatically on power loss"
# sudo pmset -a autorestart 1

# echo "  › Restart automatically if the computer freezes"
# sudo systemsetup -setrestartfreeze on

# echo "  › Sleep the display after 15 minutes"
# sudo pmset -a displaysleep 15

# echo "  › Disable machine sleep while charging"
# sudo pmset -c sleep 0

# echo "  › Set machine sleep to 5 minutes on battery"
# sudo pmset -b sleep 5

echo "  › Speed up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

# Never go into computer sleep mode
# sudo systemsetup -setcomputersleep Off > /dev/null

# go into computer sleep mode after 20min
# sudo systemsetup -setcomputersleep 20

echo "  › Disable hibernation (speeds up entering sleep mode)"
sudo pmset -a hibernatemode 0

echo "  › Remove the sleep image file to save disk space"
sudo rm /private/var/vm/sleepimage
echo "  › Create a zero-byte file instead..."
sudo touch /private/var/vm/sleepimage
echo "  › ...and make sure it can’t be rewritten"
sudo chflags uchg /private/var/vm/sleepimage

echo "  ›  Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0

###############################################################################
# Finder                                                                      #
###############################################################################

echo ""
echo "› Finder:"
echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# echo "  › Set the Finder prefs for showing a few different volumes on the Desktop"
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  › Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "  › When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  › Use AirDrop over every interface"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "  › Show the ~/Library folder"
chflags nohidden ~/Library

echo "  › Show the /Volumes folder"
sudo chflags nohidden /Volumes

###############################################################################
# Photos                                                                      #
###############################################################################

echo ""
echo "› Photos:"
echo "  › Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo ""
echo "› Browsers:"
echo "  › Setup Safari for development"

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

echo "  › Allow installing user scripts via GitHub Gist or Userscripts.org"
defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

echo "  › Disable the annoying backswipe on trackpads (Chrome)"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

echo "  › Disable the annoying backswipe on Magic Mouse (Chrome)"
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# echo "  › Use the system-native print preview dialog (Chrome)"
#defaults write com.google.Chrome DisablePrintPreview -bool true
#defaults write com.google.Chrome.canary DisablePrintPreview -bool true

echo "  › Expand the print dialog by default (Chrome)"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# #############################

# echo ""
# echo "› Dock"
# echo "  › Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
# defaults write com.apple.dock tilesize -int 36

# echo "  › Speeding up Mission Control animations and grouping windows by application"
# defaults write com.apple.dock expose-animation-duration -float 0.1
# defaults write com.apple.dock "expose-group-by-app" -bool true

# echo "  › Remove the auto-hiding Dock delay"
# defaults write com.apple.dock autohide-delay -float 0
# echo "  › Remove the animation when hiding/showing the Dock"
# defaults write com.apple.dock autohide-time-modifier -float 0

# echo "  › Automatically hide and show the Dock"
# defaults write com.apple.dock autohide -bool true

# echo "  › Don't animate opening applications from the Dock"
# defaults write com.apple.dock launchanim -bool false

# #############################

# echo ""
# echo "› Mail:"
# echo "  › Add the keyboard shortcut CMD + Enter to send an email"
# defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"
# # shellcheck disable=SC2016
# defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Archive" '@$e'

# echo "  › Disable smart quotes as it's annoying for messages that contain code"
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# echo "  › Set email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'"
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# echo "  › Display emails in threaded mode, sorted by date (oldest at the top)"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# echo "  › Disable inline attachments (just show the icons)"
# defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# # echo "  › Disable automatic spell checking"
# # defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

# echo "  ›  Disable send and reply animations in Mail.app"
# defaults write com.apple.mail DisableReplyAnimations -bool true
# defaults write com.apple.mail DisableSendAnimations -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

echo ""
echo "› Time Machine:"
echo "  › Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "  › Disable local Time Machine backups"
# https://classicyuppie.com/what-crap-is-this-os-xs-mobilebackups/
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Finalize and Kill affected applications                                     #
###############################################################################

echo ""
echo "› Kill related apps"
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission" "Photos"; do
  killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
