require 'sinatra'
require 'JSON'

def initialize 
  @favorites = {}
end

get '/' do
  File.read(File.join('views', 'index.html'))
end

get '/favorites' do
  response.header['Content-Type'] = 'application/json'
  File.read('data.json')
end

post '/favorites' do
  file = JSON.parse(File.read(File.join('data.json')))
  unless params[:name] && params[:oid]
    return 'Invalid Request'
  end
  movie = { name: params[:name], oid: params[:oid] }
  file << movie
  File.write('data.json',JSON.pretty_generate(file))
  movie.to_json
end
