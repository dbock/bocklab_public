
# first run startup.R and functions.R

# scale Z from 35nm to 40nm, now uPN is 40nm thickness
uPN = nlapply(uPN, scale, center=FALSE, scale=c(1,1,35/40))

pns = nlapply(pns, scale, center=FALSE, scale=c(1,1,35/40))

# update landmarks Z from 35nm to 40nm, and update the bridging transformation JFRC2013_FAFB13 accordingly
elm.landmarks = elmr::elm.landmarks

elm.landmarks$Z1 = scale(elm.landmarks$Z1, center=FALSE, scale=35/40)

m <- rgl::identityMatrix()
diag(m) <- c(nat::voxdims(nat.flybrains::JFRC2013),1)

elmlm=elm.landmarks[elmr::elm.landmarks[,"Use"],]
l0=data.matrix(elmlm[,c("X","Y","Z"), drop=F])
l1=data.matrix(elmlm[, c("X1", "Y1", "Z1"), drop = F])
JFRC2013_FAFB13 <- nat::reglist(tpsreg(l1, l0), m)
nat.templatebrains::add_reglist(JFRC2013_FAFB13,
                                reference = nat.flybrains::JFRC2013,
                                sample = elmr::FAFB13)

# figure to re-run:
# Fig4D (checked), Fig5B & C (checked), FigS7 B & C(checked)
# Table S1 (checked)


