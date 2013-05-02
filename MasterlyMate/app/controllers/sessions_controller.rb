#########################################################################
#Copyright 2013 Michael Gruben, Julian Babics, Benjamin Merkle
#
#This file is part of Masterly Mate.
#
#Masterly Mate is free software: you can redistribute it and/or modify it
#under the terms of the GNU Affero General Public License as published by
#the Free Software Foundation, either version 3 of the License, or (at
#your option) any later version.
#
#Masterly Mate is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU Affero General Public License for more details.
#
#You should have received a copy of the GNU Affero General Public License
#along with Masterly Mate.  If not, see <http://www.gnu.org/licenses/>.
#
#Diese Datei ist Teil von Masterly Mate.
#
#Masterly Mate ist Freie Software: Sie können es unter den Bedingungen
#der GNU Affero General Public License, wie von der Free Software
#Foundation, Version 3 der Lizenz oder (nach Ihrer Option) jeder späteren
#veröffentlichten Version, weiterverbreiten und/oder modifizieren.
#
#Masterly Mate wird in der Hoffnung, dass es nützlich sein wird, aber
#OHNE JEDE GEWÄHELEISTUNG, bereitgestellt; sogar ohne die implizite
#Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN
#ZWECK.
#Siehe die GNU Affero General Public License für weitere Details.
#
#Sie sollten eine Kopie der GNU Affero General Public License zusammen
#mit Masterly Mate erhalten haben. Wenn nicht, siehe
#<http://www.gnu.org/licenses/>.
#########################################################################

class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_username_none_case_sensitive(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "#{t('login.successful')}, #{user.username}"
    else
      flash[:error] = t("login.failed")
      redirect_to "#{root_path}?failed=1"
      #if controller.send(:_layout).identifier.split('/').last.split('.').first == "backend"
      #  redirect_to admin_path
      #else
      #  redirect_to root_path
      #end
    end 
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t("logout.successful")
  end
  
end
