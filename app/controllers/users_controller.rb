class UsersController < ApplicationController
  
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
    
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  

  def bookmarks
    @user = User.find_by(id: params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id)
  end
  
  def messages
    @user = User.find_by(id: params[:id])
    @currentEntries = @current_user.entries
    myRoomIds = []
    
    @currentEntries.each do |e|
      myRoomIds << e.room.id
    end
    
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?', @user.id)
    
    @currentUserEntry=Entry.where(user_id: @current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    @currentUserEntry.each do |cu|
      @userEntry.each do |u|
        if cu.room_id == u.room_id
          @isRoom = true
          @roomId = cu.room_id
        end
      end
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] ="権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
