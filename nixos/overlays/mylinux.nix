self: super:
	let 
		k = super.lib.kernel;

		myConfig = {
			HYPERV_TESTING = k.yes;

			SCHED_CORE = super.lib.mkForce k.no;

			RUST = k.yes;
			RUST_DEBUG_ASSERTIONS = k.no;
			RUST_OVERFLOW_CHECKS = k.no;
			RUST_BUILD_ASSERT_ALLOW = k.no;
		};

		myPatches = [
			# patches
		];

		base = super.linuxKernel.kernels.linux_zen;
	in
	{
		myCoreLinux = base.override {
			structuredExtraConfig = myConfig;
			extraPatches = myPatches;
			extraMakeFlags = [ "LLVM=1" ];
			extraNativeBuildInputs = with super; [
				rustc
				rust-bindgen
				rustfmt
				clang
				llvmPackages.bintools
				(super.writeTextFile {
					name = "env-RUST_LIB_SRC";
					destination = "/nix-support/setup-hook";
					text = ''
						export RUST_LIB_SRC="${rust.packages.stable.rustPlatform.rustLibSrc}"
					'';
				})
			];

		};

		myLinux = super.linuxKernel.packagesFor self.myCoreLinux;
	}
