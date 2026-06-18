function __awsr_list --description 'Complete AWS region list (code + location) for awsr'
    # All commercial (aws partition) regions, sourced from botocore endpoints.json.
    # [opt-in] = disabled by default; must be enabled per-account before use
    # (see: aws account list-regions / Account settings) or API calls will fail.
    # Offline, no creds needed. Own file so awsr and its completion can autoload it.
    printf '%s\n' \
        'af-south-1     Africa (Cape Town)          [opt-in]' \
        'ap-east-1      Asia Pacific (Hong Kong)    [opt-in]' \
        'ap-east-2      Asia Pacific (Taipei)       [opt-in]' \
        'ap-northeast-1 Asia Pacific (Tokyo)' \
        'ap-northeast-2 Asia Pacific (Seoul)' \
        'ap-northeast-3 Asia Pacific (Osaka)' \
        'ap-south-1     Asia Pacific (Mumbai)' \
        'ap-south-2     Asia Pacific (Hyderabad)    [opt-in]' \
        'ap-southeast-1 Asia Pacific (Singapore)' \
        'ap-southeast-2 Asia Pacific (Sydney)' \
        'ap-southeast-3 Asia Pacific (Jakarta)      [opt-in]' \
        'ap-southeast-4 Asia Pacific (Melbourne)    [opt-in]' \
        'ap-southeast-5 Asia Pacific (Malaysia)     [opt-in]' \
        'ap-southeast-6 Asia Pacific (New Zealand)  [opt-in]' \
        'ap-southeast-7 Asia Pacific (Thailand)     [opt-in]' \
        'ca-central-1   Canada (Central)' \
        'ca-west-1      Canada West (Calgary)       [opt-in]' \
        'eu-central-1   Europe (Frankfurt)' \
        'eu-central-2   Europe (Zurich)             [opt-in]' \
        'eu-north-1     Europe (Stockholm)' \
        'eu-south-1     Europe (Milan)              [opt-in]' \
        'eu-south-2     Europe (Spain)              [opt-in]' \
        'eu-west-1      Europe (Ireland)' \
        'eu-west-2      Europe (London)' \
        'eu-west-3      Europe (Paris)' \
        'il-central-1   Israel (Tel Aviv)           [opt-in]' \
        'me-central-1   Middle East (UAE)           [opt-in]' \
        'me-south-1     Middle East (Bahrain)       [opt-in]' \
        'mx-central-1   Mexico (Central)            [opt-in]' \
        'sa-east-1      South America (Sao Paulo)' \
        'us-east-1      US East (N. Virginia)' \
        'us-east-2      US East (Ohio)' \
        'us-west-1      US West (N. California)' \
        'us-west-2      US West (Oregon)'
end
