---
title: Volumetric Aurora
date: 2026-02-13
tags:
  - project
  - graphics
  - Unreal_Engine_5
---

%% <iframe width="681" height="383" src="https://www.youtube.com/embed/QUAofjz6ewg" title="Volumetric Aurora" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe> %%

![[Volumetric Aurora 시연 영상.mp4]]

_실제 사용 영상_

# 프로젝트 정보

- 개발 기간: 7주
- 팀: Risk&Benefit (4인)
- 팀 멤버:
	- [김민찬](https://github.com/mcminchan1021)
	- [김진철](https://github.com/fuenell)
	- [박선하](https://github.com/Sunha-i)
	- [홍신화](https://github.com/budnarae)
- 담당 역할: **Flow Type 오로라 시스템 설계 및 구현** (벡터장 기반 유동 시뮬레이션)
- Fab: https://www.fab.com/listings/57cba704-cfa8-4014-b6c2-b582822ce3fc
- 공식 문서: https://riskandbenefit.github.io/VolumetricAurora_Docs/docs

# 개요

Volumetric Aurora는 Unreal Engine 5 기반의 실시간 오로라 렌더링 플러그인입니다.

핵심 목표는 다음 3가지입니다.

1. 사용자가 빠르고 직관적으로 원하는 오로라를 만들 수 있을 것
2. 기본 프리셋을 바로 사용할 수 있으면서도, 필요한 경우 세부 커스터마이징이 가능할 것
3. 볼륨 렌더링으로 실제 오로라에 가까운 입체감을 표현할 것

최대한 다양한 형태의 오로라를 지원하기 위해 `Noise`, `Spline`, `Flow` 3가지 타입을 제공합니다.

# 사용법

작업 흐름은 다음 순서로 진행합니다.

1. 오로라 타입 선택 (`Noise / Spline / Flow`)
2. 공통 파라미터 조정 (색, 밀도, 고도, 범위, 감쇠)
3. 타입별 파라미터 조정
4. 필요 시 설정을 Data Asset으로 저장해 재사용

![[9f88b53e643e49f83f5e0c3ca99e1e32_MD5.jpg | 500]]
_다양한 오로라 파라미터_

![[a9514ec251d7cb27f2681c5668893a33_MD5.jpg | 500]]
_Data Asset 형태로 저장된 파라미터_

# 시스템 구조

플러그인은 역할 기준으로 3개 모듈로 분리합니다.

1. `VolumetricAurora` (Runtime)
- 오로라 액터, 프리셋 데이터, 프레임 업데이트 로직

2. `VolumetricAuroraEditor` (Editor)
- 프리셋 관리, 디테일 패널 커스터마이징, 페인터/프리뷰 UI

3. `VolumetricAuroraShaders` (Runtime)
- Compute Shader 등록, 셰이더 소스 경로 매핑

이 구조는 런타임 렌더링 코드와 에디터 제작 도구를 분리해 유지보수와 확장을 단순하게 만듭니다.

# 구현 원리

## Noise Aurora

Noise 타입은 노이즈 텍스처를 서로 다른 UV 좌표에서 샘플링하고, 샘플 차이를 이용해 커튼형 패턴을 만듭니다.
시간에 따라 UV를 이동시키면 막이 흔들리는 듯한 움직임이 생깁니다.

```text
for each pixel_uv:
  forward_sample_uv = pixel_uv * shape_frequency + scroll_velocity * time
  backward_sample_uv = pixel_uv * shape_frequency - scroll_velocity * time
  forward_noise_value = sample_noise(shape_texture, forward_sample_uv)
  backward_noise_value = sample_noise(shape_texture, backward_sample_uv)
  curtain_shape = shape_from_difference(forward_noise_value - backward_noise_value, smoothness)
  mask_value = sample_mask(mask_texture, pixel_uv, mask_frequency, mask_scroll_speed)
  density = curtain_shape * mask_value * base_density
```

_Noise 커튼 패턴 생성 핵심 흐름 (의사 코드)_

![[ae9880400900e9088b9ef28d46772b41_MD5.mp4]]
_Noise 타입 오로라 생성 과정. UV 좌표 변위에 따라 커튼 형상이 변화한다_

## Spline Aurora

Spline 타입은 곡선 경로를 거리장(Distance Field) 텍스처로 변환한 뒤, 경로까지의 거리를 기준으로 밀도를 계산합니다.
거리값이 작을수록 리본 중심에 가깝고, 거리값이 클수록 경계 바깥으로 봅니다.
왜곡(distortion)은 노이즈를 이용해 샘플 좌표를 흔들어, 오로라가 일렁이는 애니메이션 효과를 부여합니다.

```text
for each pixel_uv:
  distance_to_spline = sample_distance_field(distance_field_texture, pixel_uv)
  if distance_to_spline < ribbon_thickness:
    edge_factor = 1 - saturate(distance_to_spline / ribbon_thickness)
    distortion_offset = sample_distortion_noise(noise_texture, pixel_uv, time) * distortion_strength
    density = edge_factor * height_falloff * (1 + distortion_offset)
  else:
    density = 0
```

_Spline 거리장 기반 밀도 계산 핵심 흐름 (의사 코드)_

![[3ca2fcdb4a169526588bdf82d2dcc780_MD5.jpg | 500]]
_Distance Field 텍스처. 픽셀의 R값이 곡선으로부터의 거리를 나타내며, 거리가 가까울수록 어둡게 표시된다_

## Flow Aurora

Flow 타입은 벡터장(Vector Field) 기반 시뮬레이션입니다.
벡터장은 각 위치에서 입자가 어느 방향과 강도로 이동할지를 담는 장입니다.
컨트롤 포인트는 위치, 타입, 강도, 감쇠 시작/종료 값을 갖고, 픽셀과의 거리 기반 가중치를 계산해 기본 유속(base flow)에 힘을 더하는 방식으로 벡터장을 지역적으로 수정합니다.

예를 들어 Source는 오로라 입자를 밀어내고, Sink는 끌어당기며, Vortex는 회전 성분을 만듭니다.
감쇠 범위(attenuation)는 중심에서 멀어질수록 힘이 얼마나 줄어드는지를 결정합니다.

시뮬레이션은 더블 버퍼링(Double Buffering)으로 진행합니다.
CS에서는 동일 리소스를 같은 패스에서 입력(SRV)과 출력(UAV)으로 동시에 안전하게 쓰는 데 제약이 있고, 다수 스레드가 같은 위치에 쓰면 데이터 레이스가 발생할 수 있습니다.
따라서 매 프레임 `BackBuffer`를 읽고 `FrontBuffer`에 쓴 뒤, `FrontBuffer`를 다음 패스로 전달하며, 마지막에 `BackBuffer`와 `FrontBuffer`를 `swap`합니다. 이를 통해 매 프레임 최신화된 계산 결과를 렌더링에 반영할 수 있습니다.

입자의 흐름(advection)은 위 구조와 맞물리도록 Semi-Lagrangian 방식으로 계산합니다.
Forward advection처럼 "현재 값을 앞으로 뿌리는" 방식은 여러 스레드가 같은 픽셀에 동시에 쓰는 상황을 만들 수 있습니다.
Semi-Lagrangian은 반대로 "현재 픽셀에서 과거 위치를 역추적"(`previous_uv = current_uv - velocity * dt`)해 읽기 중심으로 계산하므로, 동시 쓰기 충돌을 줄이고 실시간에서 더 안정적으로 동작합니다.

```text
read_buffer = BackBuffer
write_buffer = FrontBuffer

for each simulation_cell_uv:
  flow_velocity = base_flow + sum_control_point_forces(simulation_cell_uv)
  previous_uv = simulation_cell_uv - flow_velocity * delta_time
  advected_density = sample(read_buffer, previous_uv)
  emitted_density = sample_emitter(shape_texture, simulation_cell_uv, time)
  write_buffer[simulation_cell_uv] = combine(advected_density, emitted_density, obstacle_field)

swap(FrontBuffer, BackBuffer)
```

_Flow 벡터장 입자의 흐름(advection) + 더블 버퍼링 핵심 흐름 (의사 코드)_

체크포인트 기능은 시뮬레이션 스냅샷을 저장/복원해, 씬 시작 직후 완성된 상태를 바로 보여주는 용도로 사용합니다.

![[aa29967b217cf789208029a70d63c638_MD5.mp4]]
_Flow 타입의 Front Buffer 시각화. 벡터장의 영향을 받아 입자들이 실시간으로 이동한다_

# 렌더링

최종 출력은 볼륨 레이마칭으로 계산합니다.
카메라에서 광선을 발사하고 볼륨 내부를 일정 간격으로 전진하며 밀도와 색을 누적해, 평면 텍스처(빌보드/카드)를 여러 장 겹쳐 표현하는 방식보다 깊이감 있는 결과를 만듭니다.

![[d04ab76ea7be66c45b2e18713024dd47_MD5.mp4]]
_레이 마칭 원리. 카메라에서 발사된 광선이 일정 간격으로 샘플링하며 볼륨 데이터를 누적한다_

![[ddf2897e8d69a3f1520020425eab5059_MD5.mp4]]
_광선이 전진할수록 형태를 갖추어 나가는 오로라_

# 중첩 발광 제어

오로라가 겹치는 구간은 밝기가 너무 빨리 올라가 흰색에 가까운 단색으로 뭉개지기 쉽습니다.
이 구간은 누적, 감쇠, 톤 정리를 함께 적용해 제어합니다.

```text
remaining_transmittance = 1
accumulated_color = 0

for each ray_step:
  sampled_density = sample_density(ray_step)
  step_opacity = 1 - clamp(1 - sampled_density, 0, 1)
  accumulated_color += sample_color(ray_step) * step_opacity * remaining_transmittance
  remaining_transmittance *= (1 - step_opacity)

final_color = tone_shaping(accumulated_color, contrast, pivot, saturation)
```

_중첩 구간 밝기 포화 방지를 위한 누적/감쇠/톤 셰이핑 흐름 (의사 코드)_

# 결론

Volumetric Aurora는 GPU 기반 형태 생성과 레이 마칭 볼륨 렌더링을 결합한 오로라 시스템입니다. 녹화된 영상 대신 절차적 생성 방식을 사용하여 색상과 형태를 실시간으로 제어할 수 있으며, 세 가지 생성 방식을 통해 다양한 오로라 연출을 지원합니다.

특히 Flow 타입의 경우 벡터장 기반 시뮬레이션으로 기존에 구현하기 어려웠던 유동적인 오로라 표현을 실시간으로 구현했습니다.

# 참고 레퍼런스

- [Double Buffering](https://learn.microsoft.com/en-us/windows/uwp/graphics-concepts/swap-chains)
- [Semi-Lagrangian / Backward Advection](https://en.wikipedia.org/wiki/Semi-Lagrangian_scheme)
- [Distance Field](https://iquilezles.org/articles/distfunctions/)
- [Volume Rendering / Ray Marching](https://advances.realtimerendering.com/s2015/The%20Real-time%20Volumetric%20Cloudscapes%20of%20Horizon%20-%20Zero%20Dawn%20-%20ARTR.pdf)
