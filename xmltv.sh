#!/bin/bash

# Input files (M3U)
input_file1="stream.m3u8"
input_file2="tv.m3u8"

# Output file (XMLTV)
output_file="epg-stream.xml"

# XMLTV Header
echo '<?xml version="1.0" encoding="UTF-8"?>' > "$output_file"
echo '<tv>' >> "$output_file"

# Read and combine EPG data from M3U files into XMLTV format
while IFS= read -r line; do
    if [[ $line == *"#EXTINF:"* ]]; then
        # Extract channel name and EPG data
        channel_name=$(echo "$line" | sed 's/#EXTINF:-1,//;s/,.*//')
        epg_data=$(echo "$line" | sed 's/#EXTINF:-1,[^,]*,//')

        # Add the Channel to XMLTV file
        echo "  <channel id=\"$channel_name\">" >> "$output_file"
        echo "    <display-name>$channel_name</display-name>" >> "$output_file"
        echo "  </channel>" >> "$output_file"

        # Add EPG data
        echo "  <programme start=\"$(date +%Y%m%d%H%M%S) +0000\" stop=\"$(date +%Y%m%d%H%M%S -d '+1 hour') +0000\" channel=\"$channel_name\">" >> "$output_file"
        echo "    <title>$epg_data</title>" >> "$output_file"
        echo "  </programme>" >> "$output_file"
    fi
done < "$input_file1" && {
    while IFS= read -r line; do
        if [[ $line == *"#EXTINF:"* ]]; then
            # Extract channel name and EPG data
            channel_name=$(echo "$line" | sed 's/#EXTINF:-1,//;s/,.*//')
            epg_data=$(echo "$line" | sed 's/#EXTINF:-1,[^,]*,//')

            # Add the Channel to XMLTV file
            echo "  <channel id=\"$channel_name\">" >> "$output_file"
            echo "    <display-name>$channel_name</display-name>" >> "$output_file"
            echo "  </channel>" >> "$output_file"

            # Add EPG data
            echo "  <programme start=\"$(date +%Y%m%d%H%M%S) +0000\" stop=\"$(date +%Y%m%d%H%M%S -d '+1 hour') +0000\" channel=\"$channel_name\">" >> "$output_file"
            echo "    <title>$epg_data</title>" >> "$output_file"
            echo "  </programme>" >> "$output_file"
        fi
    done < "$input_file2"
}

# XMLTV Footer
echo '</tv>' >> "$output_file"

echo "EPG data was successfully saved to $output_file."
