within TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3;
partial model PartialDistributedVolume
  "Base class for distributed 3-D volume models"
  import Modelica.Fluid.Types.Dynamics;

  replaceable package Material =
    TRANSFORM.Media.Interfaces.PartialAlloy
    "Material properties" annotation (choicesAllMatching=true);
  parameter Integer nVs[3](min=1) = {1,1,1} "Number of discrete volumes";

  // Inputs provided to the volume model
  input SI.Volume Vs[nVs[1],nVs[2],nVs[3]](min=0) "Discretized volumes"
    annotation (Dialog(group="Input Variables"));

  // Initialization
  parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
    "Formulation of energy balances"
    annotation (Dialog(tab="Initialization", group="Dynamics"));

  parameter SI.Temperature Ts_start[nVs[1],nVs[2],nVs[3]]=fill(
      Material.T_reference,
      nVs[1],
      nVs[2],
      nVs[3]) "Temperature"
    annotation (Dialog(tab="Initialization", group="Start Value: Temperature"));

  Material.BaseProperties materials[nVs[1],nVs[2],nVs[3]](T(each stateSelect=
          StateSelect.prefer, start=Ts_start));

  // Total quantities
  SI.Mass ms[nVs[1],nVs[2],nVs[3]] "Mass";
  SI.InternalEnergy Us[nVs[1],nVs[2],nVs[3]] "Internal energy";

  // Energy Balance
  SI.HeatFlowRate Ubs[nVs[1],nVs[2],nVs[3]]
    "Energy sources across volume interfaces (e.g., thermal diffusion) and source/sinks within volumes (e.g., ohmic heating, external convection)";

initial equation
  if energyDynamics == Dynamics.SteadyStateInitial then
    der(Us) = zeros(
      nVs[1],
      nVs[2],
      nVs[3]);
  elseif energyDynamics == Dynamics.FixedInitial then
    materials.T = Ts_start;
  end if;

equation

  // Total Quantities
  for i in 1:nVs[1] loop
    for j in 1:nVs[2] loop
      for k in 1:nVs[3] loop
        ms[i, j, k] = Vs[i, j, k]*materials[i, j, k].d;
        Us[i, j, k] = ms[i, j, k]*materials[i, j, k].u;
      end for;
    end for;
  end for;

  // Energy Balance
  if energyDynamics == Dynamics.SteadyState then
    for i in 1:nVs[1] loop
      for j in 1:nVs[2] loop
        for k in 1:nVs[3] loop
          0 = Ubs[i, j, k];
        end for;
      end for;
    end for;
  else
    for i in 1:nVs[1] loop
      for j in 1:nVs[2] loop
        for k in 1:nVs[3] loop
          der(Us[i, j, k]) = Ubs[i, j, k];
        end for;
      end for;
    end for;
  end if;

  annotation (Documentation(info="<html>
<p>The following boundary flow and source terms are part of the energy balance and must be specified in an extending class: </p>
<ul>
<li>Qb_flows[nVs[1],nVs[2],nVs[3]], heat flow term (e.g., conductive heat flows across discritized boundaries)</li>
<li>Qb_volumes[nVs[1],nVs[2],nVs[3]], sources of energy that are calculated from volume element state (e.g., convection or internal heat generation)</li>
</ul>
<p>The following input variables need to be set in an extending class to complete the model: </p>
<ul>
<li>Vs[nVs[1],nVs[2],nVs[3]], distributed volumes</li>
</ul>
</html>"));
end PartialDistributedVolume;
