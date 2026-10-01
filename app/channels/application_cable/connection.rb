module ApplicationCable
  # Live updates only send "refresh this page" to signed stream names a page was
  # given by the server, so connections without a session are allowed: the viewer
  # page (a personal link, no account) listens to its household too.
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      set_current_user
    end

    private
      def set_current_user
        if session = Session.find_by(id: cookies.signed[:session_id])
          self.current_user = session.user
        end
      end
  end
end
