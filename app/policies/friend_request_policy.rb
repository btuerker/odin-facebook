class FriendRequestPolicy < ApplicationPolicy
    attr_reader :user, :friend_request

    def initialize(user, friend_request)
        super
        @user = user
        @friend_request = friend_request
    end
    
    def accept?
        @friend_request.present? && @friend_request.persisted? && 
        receiver? && pending?
    end

    def decline?
        @friend_request.present? && @friend_request.persisted? && 
        receiver? && pending?
    end

    def destroy?
        @friend_request.present? && @friend_request.persisted? && sender?
    end
    
    private

    def sender? 
        @user && @user == @friend_request.sender
    end
    
    def receiver?
        @user && @user == @friend_request.receiver
    end

    def pending?
        @friend_request.status == 0
    end
end