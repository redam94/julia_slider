### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ bc2d061d-f1d2-4ef9-9361-2d068b0afaef
begin
	import Pkg
	Pkg.activate(".")
	Pkg.add([
		"PlutoUI",
		"Random",
		"Turing",
		"Plots"
	])
end

# ╔═╡ 5404fef6-0ceb-11ef-0c2e-056033a575d4
using PlutoUI, Random, Turing, Plots

# ╔═╡ ac89180b-343a-4b91-92fa-7666b8da3fd3
λ = (@bind s Slider(1:1:10, show_value=true))

# ╔═╡ 811af22c-a9f7-45ff-84ec-4e610d5e2d01
let
	x = 0:.01:10
	y = @. sin(2*π*x/ s)
	plot(x, y)
end

# ╔═╡ Cell order:
# ╠═bc2d061d-f1d2-4ef9-9361-2d068b0afaef
# ╠═5404fef6-0ceb-11ef-0c2e-056033a575d4
# ╠═ac89180b-343a-4b91-92fa-7666b8da3fd3
# ╠═811af22c-a9f7-45ff-84ec-4e610d5e2d01
