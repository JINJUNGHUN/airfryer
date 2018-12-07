class Ability
  include CanCan::Ability

  def initialize(user)
  #user -> current_user
    user ||= User.new # guest user (not logged in)
    # 어드민 권한
    if user.has_role? :admin
     can :manage, :all #create, edit 등

    else
    #일반 회원 권한 : 비허용
    #cannot [:index, :show, :new, :create], Post

    #일반 회원 권한 : 허용
    can [:index, :show, :new, :create], Post
    can [:edit, :update, :destroy], Post, user_id: user.id
    # can :destroy, Comment, user_id: user.id
    end
  end
end
