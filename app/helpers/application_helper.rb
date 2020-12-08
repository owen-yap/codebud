module ApplicationHelper
  def avatar(user)
    if user.photo.attached?
      cl_image_tag user.photo.key, class: "avatar-sm"
    else
      image_tag "default_profile.jpg", class: "avatar-sm"
    end
  end
end
