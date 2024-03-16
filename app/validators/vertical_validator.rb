class VerticalValidator < ActiveModel::Validator
  def validate(record)
    if Category.pluck(:name).include?(record.name)
      record.errors.add :name, "This name is already used in a Category"
    end
  end
end
