module FlashesHelper
  def user_facing_flashes
    f = flash.to_hash.slice("alert", "error", "notice", "success")
    f["warning"] = f.delete "alert" if f["alert"]
    f["danger"] = f.delete "error" if f["error"]
    f["info"] = f.delete "notice" if f["notice"]
    f
  end
end
