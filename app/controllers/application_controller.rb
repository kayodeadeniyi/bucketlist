class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Helpers
  before_filter :add_allow_credentials_headers
  serialization_scope :current_user
  helper_method :current_user

  def current_user
    @current_user
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :no_route_found
  rescue_from ::Exception, with: :error_occurred


  def no_route_found
    response = {status: 'failure', body: 'no route found'}
    render json: response.to_json
  end

  protected

    def record_not_found(exception)
      response = {status: 'failure', body: 'record not found', error: exception.message.to_s}
      render json: response.to_json
    end


    def error_occurred(exception)
      response = {status: 'failure', body: 'an error occurred', error: exception.message.to_s}
      render json: response.to_json
    end

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(auth_token: token)
      end
      if !@current_user.nil?
        if @current_user.login == false
          self.headers['WWW-Authenticate'] = 'Token realm="Application"'
          render json: 'Invalid token', status: 401
        else
          true
        end
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end

end
