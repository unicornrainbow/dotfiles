os :osx do
  folder "/Users/myfreeweb/Downloads" do
    downloaded_from %r{destroyallsoftware} do
      open
    end

    ext :html do # Accidental opt+clicks in a browser
      trash
    end
  end
end
