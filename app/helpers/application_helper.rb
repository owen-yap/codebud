module ApplicationHelper
  def avatar(user)
    if user.photo.attached?
      cl_image_tag user.photo.key, height: 300, width: 400, class: "avatar-sm", crop: :fill
    else
      image_tag "default_profile.jpg", height: 300, width: 400, class: "avatar-sm", crop: :fill
    end
  end
end
