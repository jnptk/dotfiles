function va -d "Activate Python venv from .venv in current dir"
    if [ -e  ".venv/bin/activate.fish" ]
        source .venv/bin/activate.fish
        echo ".venv/bin/activate.fish"
    else
        return 1
    end
end
