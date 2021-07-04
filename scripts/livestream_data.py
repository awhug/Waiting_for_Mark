import requests
import json

# Here are all the video ID's I could find
video_ids = ['JESUlbHPBuM', 'vl0o93yuqyI', 'PXHpjNsqyWg', 'rU2jnmmUAyQ', 
    'yCxJYaPj7C4', 'NSOnZBl04Tc', 'RGkSK-mjPik', '7DOEiVwHjD4', '7EA5A2QttKs',
    'yW4sbZTQSJQ', 'buSG7NeBoew', 'ylWDErXZQiA', 'H2URdABs4BQ', 'DStXtvSQ1hM',
    'HFCHzGdmilw', 'QlpVuAyX6LE', 'ieujsrI9aqY', '0qbf4LKB6r8', 'iJdMUlWUnHc',
    'C4lFu2wW3h4', 'tpwjAPIHuBU', 'e8fLVO321JA', 'rB5NWdrh3f8']

# Function to grab all videos
def get_video_statistics(api_key, video_ids):

    video_data = dict()

    for vid in video_ids:
        url = f'https://www.googleapis.com/youtube/v3/videos?part=liveStreamingDetails&id={vid}&key={api_key}'
        json_url = requests.get(url)
        data = json.loads(json_url.text)
        video_data[vid] = data
        
    return(video_data)

# Download the data - need to input the API key
vid_data = get_video_statistics(api_key = "", video_ids = video_ids)

# Extract the live streaming details
mmg_timings = dict()
for vid in video_ids:
    mmg_timings[vid] = vid_data[vid]['items'][0]['liveStreamingDetails']

# Save the data
with open('youtube_data.json', 'w') as fp:
    json.dump(mmg_timings, fp)



        
