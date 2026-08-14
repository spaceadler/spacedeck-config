function batch_mirror -d "Loops through all local folders and links Gitea mirrors"
    # Even though you swapped to a password, your variable is still named $GITEA_API_TOKEN
    if test -z "$GITHUB_PAT" -o -z "$GITEA_API_TOKEN"
        echo "Error: Missing GitHub PAT or Gitea Password."
        return 1
    end

    for dir in (ls -d */ | string trim -c /)
        echo "Scanning: $dir"

        # Check if the repo already exists on GitHub
        # We send the output to /dev/null so it doesn't clutter your terminal
        if gh repo view spaceadler/$dir >/dev/null 2>&1
            echo "  -> GitHub repo 'spaceadler/$dir' already exists. Skipping."
            continue
        end

        # 1. Make a repo with the same folder name on GitHub
        echo "  -> Creating public GitHub repo: 'spaceadler/$dir'..."
        gh repo create spaceadler/$dir --public

        echo "  -> Wiring up Gitea Push Mirror..."
        # We capture the HTTP status code and save the error message to a temp file
        set http_code (curl -s -w "%{http_code}" -o /tmp/gitea_mirror_out.json \
            -u "spaceadler:$GITEA_API_TOKEN" \
            -X POST "http://git.spaceadler.local/api/v1/repos/spaceadler/$dir/push_mirrors" \
            -H "accept: application/json" \
            -H "Content-Type: application/json" \
            -d "{
                \"remote_address\": \"https://spaceadler:$GITHUB_PAT@github.com/spaceadler/$dir.git\",
                \"sync_on_commit\": true,
                \"interval\": \"8h\"
            }")

        # Check if the server responded with 200 (OK) or 201 (Created)
        if test "$http_code" = "200" -o "$http_code" = "201"
            echo "  -> Success: '$dir' is fully mirrored."
        else
            echo "  -> ERROR: Failed with HTTP $http_code"
            cat /tmp/gitea_mirror_out.json
            echo "" # Adds a blank line for readability
        end
    end   
    
    echo "Batch run complete."
end
