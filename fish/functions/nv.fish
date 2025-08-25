function nv -d "Simple Node version manager via Homebrew"
    set cmd $argv[1]
    set ver $argv[2]

    switch $cmd
        case install
            if test -z "$ver"
                echo "Usage: nv install <version>"
                return 1
            end

            if test "$ver" = "node"
                echo "Installing latest Node.js..."
                brew install node --quiet
            else if string match -qr '^[0-9]+$' -- $ver
                echo "Installing Node.js $ver..."
                brew install node@$ver --quiet
            else
                echo "Invalid version: $ver"
                return 1
            end

            echo "Run 'nv use $ver' to activate."

        case use
            if test -z "$ver"
                echo "Usage: nv use <version>"
                return 1
            end

            if test "$ver" = "node"
                echo "Switching to Node.js $ver..."
                brew unlink node --quiet >/dev/null
                brew link --overwrite --force node --quiet >/dev/null
            else if string match -qr '^[0-9]+$' -- $ver
                echo "Switching to Node.js $ver..."
                brew unlink node@$ver --quiet >/dev/null
                brew link --overwrite --force node@$ver --quiet >/dev/null
            else
                echo "Invalid version: $ver"
                return 1
            end

            echo "Now using Node.js "(node -v)

        case -l --list
            echo "Installed Node versions:"
            brew list --versions | grep --color="never" '^node\(@[0-9]\+\)\?'

        case -lr --list-remote
            echo "Available Node versions in Homebrew:"
            brew search node | grep --color="never" '^node\(@[0-9]\+\)\?$'

        case '*' -h --help
            echo "Simple Node version manager via homebrew"
            echo ""
            echo "Usage: nv <command> [version]"
            echo ""
            echo "Commands:"
            echo "  install <version>   Install a Node version (e.g. 20, 22)"
            echo "  use <version>       Switch to a Node version"
            echo ""
            echo "Options:"
            echo "  -l, --list          Show installed versions"
            echo "  -lr, --list-remote  Show available versions in Homebrew"
            echo "  -h, --help          Show this help message"
    end
end
