within TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3;
partial model PartialInternalMassGeneration

  replaceable package Material =
    TRANSFORM.Media.Interfaces.PartialAlloy
    "Material properties" annotation (choicesAllMatching=true,Dialog(tab="Internal Interface"));

  parameter Integer nVs[3](min=1) = {1,1,1} "Number of discrete volumes"
    annotation(Dialog(tab="Internal Interface"));
  parameter Integer nC = 1 "Number of diffusive substances" annotation (Dialog(tab="Internal Interface"));

  // Inputs provided to the model
  input Material.ThermodynamicState states[nVs[1],nVs[2],nVs[3]]
    "Volume thermodynamic state"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));

  input SI.Concentration Cs[nVs[1],nVs[2],nVs[3],nC] "Concentration in volumes"
    annotation (Dialog(group="Input Variables", tab="Internal Interface"));

  input SI.Volume Vs[nVs[1],nVs[2],nVs[3]] "Volumes"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));

  input SI.Area crossAreas_1[nVs[1]+1,nVs[2],nVs[3]] "Volume cross sectional area"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));
  input SI.Area crossAreas_2[nVs[1],nVs[2]+1,nVs[3]] "Volume cross sectional area"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));
  input SI.Area crossAreas_3[nVs[1],nVs[2],nVs[3]+1] "Volume cross sectional area"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));

  input SI.Length lengths_1[nVs[1],nVs[2],nVs[3]] "Volume length"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));
  input SI.Length lengths_2[nVs[1],nVs[2],nVs[3]] "Volume length"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));
  input SI.Length lengths_3[nVs[1],nVs[2],nVs[3]] "Volume length"
    annotation (Dialog(group="Input Variables",tab="Internal Interface"));

  // Variables defined by model
  output SI.MolarFlowRate n_flows[nVs[1],nVs[2],nVs[3],nC] "Internal mass generation"
    annotation (Dialog(
      group="Output Variables",
      tab="Internal Interface",
      enable=false));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-120,-100},{120,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/ClosureModel_Qgen.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialInternalMassGeneration;
