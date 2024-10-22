import requests

# Spotify API Program
# ---
# * Receives four lines of input (2 track names and their artists)
# * accesses and uses the spotify API to get the track's danceability socre
# * compares the score and displays which track has a higher score
#   and display the information to the user
# * @author: Tiffany Le
# * tifle@chapman.edu
# * date: 3/13/24
# * version 2.0

# function accesses and returns the user's "access token"
def get_access_token():
    CLIENT_ID = "d9171fd182b14b9eabed0770096ec9c7"
    CLIENT_SECRET = "f84f234e8cad418d82b74d365e476fdd"

    AUTH_URL = "https://accounts.spotify.com/api/token"

    # POST
    auth_response = requests.post(
        AUTH_URL,
        {
            "grant_type": "client_credentials",
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
        },
    )
    # convert the response to JSON
    auth_response_data = auth_response.json()
    return auth_response_data["access_token"]

# function takes in the song's track ID & header
# returns the song's danceability score
def song_danceability(base_url, track_id, headers):
    # actual GET request with proper header
    r = requests.get(base_url + "audio-features/" + track_id, headers=headers)
    # Convert to json
    r = r.json()
    return r["danceability"]

# main function of the program
def main():
    # print the purpose of this program
    print("This program compares the danceability scores of two tracks.")
    print("Please follow the prompts and enter the information for the two tracks")

    # save the access token
    access_token = get_access_token()
    headers = {"Authorization": "Bearer {token}".format(token=access_token)}

    # get info for the first track
    track1_name = input("Enter the name of the first track: ")
    track1_artist = input("Enter the name of the artist who recorded the first track: ")
    # get info for the second track
    track2_name = input("Enter the name of the second track: ")
    track2_artist = input("Enter the name of the artist who recorded the second track: ")

    BASE_URL = "https://api.spotify.com/v1/"

    # search for the first track
    search_track1_pt1 = BASE_URL + "search?q=" + track1_name
    search_track1 = search_track1_pt1 + "%20artist:" + track1_artist + "&type=track"
    # search for the second track
    search_track2_pt1 = BASE_URL + "search?q=" + track2_name
    search_track2 = search_track2_pt1 + "%20artist:" + track2_artist + "&type=track"

    # get response
    track1_response = requests.get(search_track1, headers=headers).json()
    track1_id = track1_response["tracks"]["items"][0]["id"]
    track2_response = requests.get(search_track2, headers=headers).json()
    track2_id = track2_response["tracks"]["items"][0]["id"]

    # get danceability
    track1_danceability = song_danceability(BASE_URL, track1_id, headers)
    track2_danceability = song_danceability(BASE_URL, track2_id, headers)

    # compare the danceability score of both song
    if(track1_danceability > track2_danceability):
        print(f"First Track ({track1_name})' danceability score: {track1_danceability}")
        print(f"Second Track ({track2_name})' danceability score: {track2_danceability}")
        print(f"The first track, {track1_name} by {track1_artist} has a higher danceability score.")
    elif (track1_danceability < track2_danceability):
        print(f"First Track ({track1_name})' danceability score: {track1_danceability}")
        print(f"Second Track ({track2_name})' danceability score: {track2_danceability}")
        print(f"The second track, {track2_name} by {track2_artist} has a higher danceability score.")
    else:
        print(f"First Track ({track1_name})' danceability score: {track1_danceability}")
        print(f"Second Track ({track2_name})' danceability score: {track2_danceability}")
        print("Both tracks have the same danceability score.")

if __name__=="__main__": 
    main() 
