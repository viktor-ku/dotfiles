function cargo-up --description 'Update rustup and all cargo-installed packages'
    echo "🔄 Updating Rust toolchain..."
    rustup update

    echo "📦 Updating cargo packages..."
    cargo install-update -a

    echo "✅ All done!"
end
