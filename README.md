# LiteFX Registry

This repository allows you to install the [LiteFX](https://litefx.crudolph.io/) engine using [vcpkg](https://www.vcpkg.io).

## Usage

First, setup vcpkg as described [here](https://github.com/microsoft/vcpkg#using-vcpkg-with-cmake). Idealy, you can use it as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). Then, create a [vcpkg manifest file](https://vcpkg.readthedocs.io/en/latest/specifications/manifests/) in the same directory as your top-level `CMakeLists.txt` file. Add a dependency to `litefx` within this file:

```json
{
  "name": "my-litefx-app",
  "version-string": "1.0",
  "supports": "windows & !arm",
  "dependencies":
  [
    {
      "name": "litefx",
      "features": [ "glm", "dx-math" ]
    }
  ]
}
```

Since LiteFX has no official port yet, create a registry `vcpkg-configuration.json` file in the same directory as your top-level `CMakeLists.txt` and manifest `vcpkg.json` files. Inside, you can declare this repository as a registry:

```json
{
  "registries":
  [
    {
      "kind": "git",
      "repository": "https://github.com/crud89/LiteFX-Registry",
      "baseline": "",
      "packages": [ "litefx" ]
    }
  ]
}
```

When you try to run `vcpkg install` on your project now, you will receive a warning similar to:

> $.registries[0] (a git registry): missing required field 'baseline' (a baseline)

To fix this, copy the full 40 byte SHA of the [latest commit](https://github.com/crud89/LiteFX-Registry/commits/main) of this repository into the `baseline` property of your registry file. Alternatively, run the following command to acquire the 40 byte SHA:

```sh
git ls-remote https://github.com/crud89/LiteFX-Registry.git main
```

If you follow the [project setup guide](https://litefx.crudolph.io/docs/md_docs_tutorials_project_setup.html#autotoc_md3) guide, the `CMakeLists.txt` file now is more simple:

```cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.16)
SET(CMAKE_TOOLCHAIN_FILE "<path_to_vcpkg>/scripts/buildsystems/vcpkg.cmake")
 
PROJECT(MyLiteFXApp LANGUAGES CXX)
 
SET(CMAKE_CXX_STANDARD 20)
FIND_PACKAGE(LiteFX 0.1 CONFIG REQUIRED)
 
ADD_EXECUTABLE(MyLiteFXApp "main.h" "main.cpp")
TARGET_LINK_LIBRARIES(MyLiteFXApp PRIVATE LiteFX.Backends.Vulkan)   # For the DirectX 12 target use: LiteFX.Backends.DirectX12. You can also add both targets here.
```

## License

The contents of this repository are licensed under the [MIT license](./LICENSE).
