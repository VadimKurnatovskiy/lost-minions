# frozen_string_literal: true

class ApplicationPolicy
  authorize :user, allow_nil: true

  def manage?
    false
  end

  def index?
    manage?
  end

  def new?
    manage?
  end

  def edit?
    manage?
  end

  def destroy?
    manage?
  end

  def create?
    new?
  end

  def update?
    edit?
  end
end
