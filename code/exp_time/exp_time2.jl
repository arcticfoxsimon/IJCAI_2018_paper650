include("graph2.jl")
include("lapl.jl")
include("Approx_large.jl")

G = read_file2("data/com-dblp.edges")

n = G.n
A = sparseAdja2(G)
#cand = zeros(n) #in general situation; candidate edges are given as a parameter.
#L = lapl(G)

#=
Ldag = mppinv(L)
vcent = zeros(n)
for i = 1:n
    vcent[i] = n*Ldag[i,i]
end
p = sortperm(vcent)
=#

k = 10
ans1 = zeros(2)
#ans2 = zeros(2)

snum = 1
#group = 3
for dep = 1: snum
    #group = ceil(Int64, dep / 5)
    #t = rand(round(Int64,n/4*(group-1))+1: round(Int64,n/4*group))
    v = rand(1:n)

    #println(v)
    #println(p[t])

    #v = p[t]
    println("start")
    ans1 = ans1 + Appro_large(v,G,A,k)
    #ans2 = ans2 + Exact_time(v,G,k)
end

ans1[1] = ans1[1] / snum
ans1[2] = ans1[2] / snum
#ans2[1] = ans2[1] / snum
#ans2[2] = ans2[2] / snum

println("Appro_time: ", ans1[1])
println("Appro_centrality: ", ans1[2])
#println("Eaxct_time: ", ans2[1])
#println("Exact_centrality: ", ans2[2])

fname = "exp_time\\exp2.txt"
f1 = open(fname,"w")
println(f1,"com-dblp")

println(f1,"Appro_time: ", ans1[1])
println(f1,"Appro_centrality: ", ans1[2])
#println(f1,"Eaxct_time: ", ans2[1])
#println(f1,"Exact_centrality: ", ans2[2])

close(f1)

#println("End")
