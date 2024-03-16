class CategoryValidator < ActiveModel::Validator
  def validate(record)
    if Vertical.pluck(:name).include?(record.name)
      record.errors.add :name, "This name is already used in a Vertical"
    end
  end
end
