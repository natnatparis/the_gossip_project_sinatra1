require 'csv'
require 'pry'

class Gossip
    attr_accessor :author, :content 

	def initialize (author, content) #initalise l'auteur et le contenue. 
		@author = author
		@content = content
	end

	def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
    	    csv << [@author, @content]
        end
	end
    
    def self.all
        all_gossips = [] #initialise le array qui va stocker tout les gossip. 
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1]) #chaque "Gossip.new" il est stocker dans le array Gossip.new
        end
        return all_gossips
    end

   
    def self.find(id)
     gossips = [] # permet de stocker la ligne csv demandée
        CSV.read("./db/gossip.csv").each_with_index do |row, index|
          if (id == index+1)  # vérifie si l'index est égale id demandé
            gossips << Gossip.new(row[0], row[1])  # si un correspond il ajoute dans array et break pour retourner l'array
            break
              end
            end
            return gossips
        end
    end 

    def self.update(id,author,content)
            gossips = []
    
            # recréé l'array et csv avec les données modifiées.
            CSV.read("./db/gossip.csv").each_with_index do |row, index|
                if id.to_i == (index + 1)    # i 
                    gossips << [author, content]
                else
                    gossips << [row[0], row[1]]
                end
            end
    
            CSV.open("./db/gossip.csv", "w") do |csv| 
                gossips.each do |row|
                csv << row
            
            end
    end
    
end
