ActiveAdmin.register Genre do
  permit_params :name, :image

  form do |f|
    f.semantic_errors # shows errors on :base

    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ''
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
