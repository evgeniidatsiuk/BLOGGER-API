module UnifiedJsonRender
  extend ActiveSupport::Concern

  def render_error(status, class_def, error = 'Something went wrong')
    msg = class_def.errors.full_messages unless class_def.nil?
    msg ||= [error.split('[').first]

    render status: status, json: {
      success: false,
      msg: msg
    }
  end
end
