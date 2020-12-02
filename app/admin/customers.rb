ActiveAdmin.register Customer do

  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :first_name, :last_name, :address, :city, :country, :province_id

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :country, :as => :string
    end
    f.actions
  end

end
