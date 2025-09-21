function aco --wraps='clear && RUSTFLAGS="-Awarnings" cargo' --description 'alias aco=clear && RUSTFLAGS="-Awarnings" cargo'
    clear && RUSTFLAGS="-Awarnings" cargo $argv
end
