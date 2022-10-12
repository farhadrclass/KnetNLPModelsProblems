#TODO rewrite to use the new cb
#TODO a plotter function 


include("..//src//utils.jl")
include("..//src//train_utils.jl")
include("..//src//Lenet_mnist.jl")
include("..//src//FC_mnist.jl")

using Knet:
    Knet,
    conv4,
    pool,
    mat,
    nll,
    accuracy,
    progress,
    sgd,
    param,
    param0,
    dropout,
    relu,
    minibatch,
    Data

T = Float32
Knet.atype() = Array{T}
(xtrn, ytrn), (xtst, ytst) = loaddata(1, T)

# size of minibatch 
m = 1000
max_epochs = 10

knetModel, myModel = lenet_prob(xtrn, ytrn, xtst, ytst, minibatchSize = m)
println("Training R2 with KNET")
trained_model = train_knetNLPmodel!(
    myModel,
    R2,
    xtrn,
    ytrn;
    mbatch = m,
    mepoch = max_epochs,
    verbose = 1,
    β = T(0.3),
    atol = T(0.05),
    rtol = T(0.05)
)


res = trained_model
epochs = res.iter_arr
acc = res.acc_arr
train_acc = res.train_acc_arr

println("Training SGD with KNET")
# # Train Knet
# trained_model_knet = train_knet(knetModel, xtrn, ytrn, xtst, ytst;mbatch=m, mepoch = 5) #TODO some reason when mepoch=max_epochs, will give error , maybe Int(max_epochs)
# res_knet = trained_model_knet[2]
# epochs_knet = res_knet[:, 1]
# acc_knet = res_knet[:, 2]
# train_acc_knet = res_knet[:, 3]


# fig = plot(
#     epochs,
#     # title = " test accuracy vs Epoch",
#     markershape = :star4,
#     acc,
#     label = "test accuracy R2",
#     legend = :bottomright,
#     xlabel = "epoch",
#     ylabel = "accuracy",
# )
# plot!(fig, epochs, markershape = :star1, acc_knet, label = "test accuracy SGD")

# # plotSamples(myModel, xtrn, ytrn, MNIST; samples=10)

# fig = plot(
#     epochs,
#     title = "train accuracy vs Epoch on Float32",
#     markershape = :star4,
#     train_acc,
#     label = "train accuracy R2",
#     legend = :bottomright,
#     xlabel = "epoch",
#     ylabel = "accuracy",
# )
# plot!(fig, epochs, markershape = :star1, train_acc_knet, label = "train accuracy SGD")


# # plotSamples(myModel, xtrn, ytrn, MNIST; samples=10)


# #Plot all

# fig = plot(
#     epochs,
#     # title = " All accuracy vs Epoch on Float32",
#     markershape = :star1,
#     acc,
#     label = "test accuracy R2",
#     legend = :bottomright,
#     xlabel = "epoch",
#     ylabel = "accuracy",
# )



# plot!(
#     fig,
#     epochs,
#     markershape = :star1,
#     train_acc,
#     label = "train accuracy R2",
#     legend = :bottomright,
#     linestyle = :dash,
# )
# plot!(fig, epochs, markershape = :star4, acc_knet, label = "test accuracy SGD")

# plot!(
#     fig,
#     epochs,
#     markershape = :star4,
#     train_acc_knet,
#     label = "train accuracy SGD",
#     linestyle = :dot,
# )
