within TRANSFORM.Fluid.ClosureRelations.MassTransfer.Models.DistributedPipe_TraceMass_1D_MultiTransferSurface;
model Shs_SinglePhase_2Region "Specify Sh | Single Phase | 2 Region - Laminar & Turbulent"

  extends PartialSinglePhase;

  input SI.SchmidtNumber Shs_lam[nMT,nSurfaces,Medium.nC]={{{
      HeatAndMassTransfer.ClosureRelations.MassTransfer.Functions.SinglePhase.InternalFlow.Sh_Laminar_Local_Developed_Circular_SiederTate(
      Res[i],
      Scs[i, k],
      sum(dlengths),
      dimensions[i]) for k in 1:Medium.nC} for j in 1:nSurfaces} for i in 1:nMT}
    "Laminar Schmidt number" annotation (Dialog(group="Input Variables"));

  input SI.SchmidtNumber Shs_turb[nMT,nSurfaces,Medium.nC]={{{
      HeatAndMassTransfer.ClosureRelations.MassTransfer.Functions.SinglePhase.InternalFlow.Sh_Turbulent_Local_Developed_Circular_DittusBoelter(
      Res[i], Scs[i, k]) for k in 1:Medium.nC} for j in 1:nSurfaces} for i in 1
      :nMT} "Turbulent Schmidt number"
    annotation (Dialog(group="Input Variables"));

  input SI.Length[nMT,nSurfaces] L_char=transpose({dimensions for i in 1:
      nSurfaces}) "Characteristic dimension for calculation of alphaM"
    annotation (Dialog(group="Input Variables"));

equation

  for i in 1:nMT loop
    for j in 1:nSurfaces loop
      Shs[i, j, :] = TRANSFORM.Math.spliceTanh(
        Shs_turb[i, j, :],
        Shs_lam[i, j, :],
        Res[i] - Re_center,
        Re_width);
    end for;
  end for;

  for i in 1:nMT loop
    for j in 1:nSurfaces loop
      alphasM[i, j, :] = Shs[i, j, :] .* diffusionCoeff[i].D_abs ./ L_char[i, j];
    end for;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Shs_SinglePhase_2Region;
