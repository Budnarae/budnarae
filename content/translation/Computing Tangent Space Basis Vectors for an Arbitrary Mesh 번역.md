---
tags:
  - graphics
  - translation
---

_빛이 있으라_

---

[원문](https://terathon.com/blog/tangent-space.html)

---

# 임의의 메시를 위한 탄젠트 공간 기저 벡터 계산

Eric Lengyel • 2004년 3월 15일

현대의 범프 매핑(노멀 매핑이라고도 함)은 메시의 각 정점에 대해 탄젠트 평면 기저 벡터가 계산될 것을 요구합니다. 이 글은 임의의 삼각형 메시에 대한 정점별 탄젠트 공간 계산 이론을 제시하고 적절한 수학을 구현하는 소스 코드를 제공합니다.

[편집: 이 유도는 [Mathematics for 3D Game Programming & Computer Graphics](https://mathfor3dgameprogramming.com/), 1판, 2001년에 처음 등장했습니다.

업데이트된 유도는 [Foundations of Game Engine Development, Volume 2: Rendering](https://foundationsofgameenginedev.com/#fged2), 2019년에 나타납니다.]

## 수학적 유도

우리는 탄젠트 공간이 x축이 범프 맵의 u 방향에 대응하고 y축이 범프 맵의 v 방향에 대응하도록 정렬되기를 원합니다. 즉, Q가 삼각형 내부의 점을 나타낸다면, 우리는 다음과 같이 쓸 수 있기를 원합니다:

$$\mathbf{Q} - \mathbf{P}_0 = (u - u_0)\mathbf{T} + (v - v_0)\mathbf{B}$$

여기서 $\mathbf{P}_0$는 삼각형의 정점 중 하나의 위치이고, $(u_0, v_0)$는 그 정점에서의 텍스처 좌표입니다. 벡터 T와 B는 텍스처 맵에 정렬된 탄젠트와 바이탄젠트 벡터이며, 이것들이 우리가 계산하고 싶은 것입니다.

정점 위치가 점 $\mathbf{P}_0$, $\mathbf{P}_1$, 그리고 $\mathbf{P}_2$로 주어지고, 대응하는 텍스처 좌표가 $(u_0, v_0)$, $(u_1, v_1)$, 그리고 $(u_2, v_2)$로 주어진 삼각형이 있다고 가정합시다. 정점 $\mathbf{P}_0$를 기준으로 작업하면 계산을 훨씬 단순하게 만들 수 있으므로, 다음과 같이 놓겠습니다:

$$\mathbf{Q}_1 = \mathbf{P}_1 - \mathbf{P}_0$$

$$\mathbf{Q}_2 = \mathbf{P}_2 - \mathbf{P}_0$$

그리고

$$(s_1, t_1) = (u_1 - u_0, v_1 - v_0)$$

$$(s_2, t_2) = (u_2 - u_0, v_2 - v_0)$$

우리는 T와 B에 대해 다음 방정식을 풀어야 합니다:

$$\mathbf{Q}_1 = s_1 \mathbf{T} + t_1 \mathbf{B}$$

$$\mathbf{Q}_2 = s_2 \mathbf{T} + t_2 \mathbf{B}$$

이것은 6개의 미지수(T와 B 각각에 대해 3개)와 6개의 방정식(두 벡터 방정식의 x, y, z 성분)을 가진 선형 시스템입니다. 이것을 다음과 같이 행렬 형태로 쓸 수 있습니다:

$$\begin{bmatrix}(\mathbf{Q}_1)_x & (\mathbf{Q}_1)_y & (\mathbf{Q}_1)_z \ (\mathbf{Q}_2)_x & (\mathbf{Q}_2)_y & (\mathbf{Q}_2)_z\end{bmatrix} = \begin{bmatrix}s_1 & t_1 \ s_2 & t_2\end{bmatrix}\begin{bmatrix}T_x & T_y & T_z \ B_x & B_y & B_z\end{bmatrix}$$

양변에 $(s, t)$ 행렬의 역행렬을 곱하면:

$$\begin{bmatrix}T_x & T_y & T_z \ B_x & B_y & B_z\end{bmatrix} = \frac{1}{s_1 t_2 - s_2 t_1}\begin{bmatrix}t_2 & -t_1 \ -s_2 & s_1\end{bmatrix}\begin{bmatrix}(\mathbf{Q}_1)_x & (\mathbf{Q}_1)_y & (\mathbf{Q}_1)_z \ (\mathbf{Q}_2)_x & (\mathbf{Q}_2)_y & (\mathbf{Q}_2)_z\end{bmatrix}$$

이것은 정점이 $\mathbf{P}_0$, $\mathbf{P}_1$, 그리고 $\mathbf{P}_2$인 삼각형에 대한 (정규화되지 않은) T와 B 벡터를 제공합니다. 단일 정점에 대한 탄젠트 벡터를 찾기 위해, 정점 법선이 일반적으로 계산되는 방식과 유사한 방법으로 그 정점을 공유하는 모든 삼각형의 탄젠트를 평균냅니다. 인접한 삼각형이 불연속적인 텍스처 매핑을 가진 경우, 경계를 따르는 정점들은 일반적으로 이미 중복되어 있습니다. 왜냐하면 어쨌든 다른 매핑 좌표를 가지기 때문입니다. 결과가 어느 삼각형에 대해서도 범프 맵의 방향을 정확하게 나타내지 못하기 때문에 우리는 그러한 삼각형의 탄젠트를 평균하지 않습니다.

정점에 대한 법선 벡터 N과 탄젠트 벡터 T와 B가 있으면, 다음 행렬을 사용하여 탄젠트 공간에서 오브젝트 공간으로 변환할 수 있습니다:

$$\begin{bmatrix}T_x & B_x & N_x \ T_y & B_y & N_y \ T_z & B_z & N_z\end{bmatrix}$$

반대 방향으로 변환하려면(오브젝트 공간에서 탄젠트 공간으로—광선 방향에 대해 하고 싶은 것), 간단히 이 행렬의 역행렬을 사용할 수 있습니다. 탄젠트 벡터들이 서로에게 또는 법선 벡터에 수직이라는 것이 반드시 참인 것은 아니므로, 이 행렬의 역행렬은 일반적으로 전치행렬과 같지 않습니다. 하지만 세 벡터가 적어도 직교에 가까울 것이라고 가정하는 것은 안전하므로, Gram-Schmidt 알고리즘을 사용하여 그것들을 직교화하는 것이 받아들일 수 없는 왜곡을 야기하지 않아야 합니다. 이 과정을 사용하면, 새로운 (여전히 정규화되지 않은) 탄젠트 벡터 $\mathbf{T'}$와 $\mathbf{B'}$는 다음과 같이 주어집니다:

$$\mathbf{T'} = \mathbf{T} - (\mathbf{N} \cdot \mathbf{T})\mathbf{N}$$

$$\mathbf{B'} = \mathbf{B} - (\mathbf{N} \cdot \mathbf{B})\mathbf{N} - \frac{(\mathbf{T'} \cdot \mathbf{B})\mathbf{T'}}{{\mathbf{T'}}^2}$$

이 벡터들을 정규화하고 정점의 탄젠트와 바이탄젠트로 저장하면, 다음 행렬을 사용하여 광선으로의 방향을 오브젝트 공간에서 탄젠트 공간으로 변환할 수 있습니다:

$$\begin{bmatrix}T'_x & T'_y & T'_z \ B'_x & B'_y & B'_z \ N'_x & N'_y & N'_z\end{bmatrix} \tag{*}$$

변환된 광선 방향과 범프 맵의 샘플의 내적을 취하면 올바른 람베르트 확산 조명 값이 생성됩니다.

외적 $\mathbf{N} \times \mathbf{T'}$를 사용하여 $m \mathbf{B'}$를 얻을 수 있으므로 정점별 바이탄젠트를 포함하는 추가 배열을 저장할 필요가 없습니다. 여기서 $m = \pm 1$은 탄젠트 공간의 손잡이(handedness)를 나타냅니다. $\mathbf{N} \times \mathbf{T'}$로부터 얻은 바이탄젠트 $\mathbf{B'}$가 잘못된 방향을 가리킬 수 있으므로 손잡이 값은 정점별로 저장되어야 합니다. m의 값은 방정식 (*)의 행렬의 행렬식과 같습니다. w 좌표에 m의 값을 보유하는 4차원 엔티티로 정점별 탄젠트 벡터 $\mathbf{T'}$를 저장하는 것이 편리할 수 있습니다. 그러면 바이탄젠트 $\mathbf{B'}$는 다음 공식을 사용하여 계산할 수 있습니다:

$$\mathbf{B'} = T'_w(\mathbf{N} \times \mathbf{T'})$$

여기서 외적은 w 좌표를 무시합니다. 이것은 정점별 m 값을 포함하는 추가 배열을 지정할 필요를 피함으로써 버텍스 셰이더에 잘 작동합니다.

## 바이탄젠트 대 바이노멀

바이노멀(binormal)이라는 용어는 (표면 법선과 u 정렬 탄젠트 방향에 수직인) 두 번째 탄젠트 방향의 이름으로 일반적으로 사용됩니다. 이것은 잘못된 명칭입니다. 바이노멀이라는 용어는 곡선 연구에서 나타나며, 곡선의 특정 점에 대한 프레네 프레임(Frenet frame)으로 알려진 것을 완성합니다. 곡선은 단일 탄젠트 방향과 두 개의 직교 법선 방향을 가지므로, 노멀과 바이노멀이라는 용어가 사용됩니다. 표면의 한 점에서 좌표 프레임을 논할 때는, 하나의 법선 방향과 두 개의 탄젠트 방향이 있으며, 이는 탄젠트와 바이탄젠트라고 불러야 합니다.

## 소스 코드

아래 코드는 로컬 좌표 시스템의 손잡이가 w 좌표에 $\pm 1$로 저장되는 4성분 탄젠트 T를 생성합니다. 그러면 바이탄젠트 벡터 B는 $\mathbf{B} = T_w(\mathbf{N} \times \mathbf{T})$로 주어집니다.

```cpp
#include "TSVector4D.h"

struct Triangle
{
    unsigned short index[3];
};

void CalculateTangentArray(long vertexCount, const Point3D *vertex, const Vector3D *normal,
    const Point2D *texcoord, long triangleCount, const Triangle *triangle, Vector4D *tangent)
{
    Vector3D *tan1 = new Vector3D[vertexCount * 2];
    Vector3D *tan2 = tan1 + vertexCount;
    ZeroMemory(tan1, vertexCount * sizeof(Vector3D) * 2);
    
    for (long a = 0; a < triangleCount; a++)
    {
        long i1 = triangle->index[0];
        long i2 = triangle->index[1];
        long i3 = triangle->index[2];
        
        const Point3D& v1 = vertex[i1];
        const Point3D& v2 = vertex[i2];
        const Point3D& v3 = vertex[i3];
        
        const Point2D& w1 = texcoord[i1];
        const Point2D& w2 = texcoord[i2];
        const Point2D& w3 = texcoord[i3];
        
        float x1 = v2.x - v1.x;
        float x2 = v3.x - v1.x;
        float y1 = v2.y - v1.y;
        float y2 = v3.y - v1.y;
        float z1 = v2.z - v1.z;
        float z2 = v3.z - v1.z;
        
        float s1 = w2.x - w1.x;
        float s2 = w3.x - w1.x;
        float t1 = w2.y - w1.y;
        float t2 = w3.y - w1.y;
        
        float r = 1.0F / (s1 * t2 - s2 * t1);
        Vector3D sdir((t2 * x1 - t1 * x2) * r, (t2 * y1 - t1 * y2) * r,
                (t2 * z1 - t1 * z2) * r);
        Vector3D tdir((s1 * x2 - s2 * x1) * r, (s1 * y2 - s2 * y1) * r,
                (s1 * z2 - s2 * z1) * r);
        
        tan1[i1] += sdir;
        tan1[i2] += sdir;
        tan1[i3] += sdir;
        
        tan2[i1] += tdir;
        tan2[i2] += tdir;
        tan2[i3] += tdir;
        
        triangle++;
    }
    
    for (long a = 0; a < vertexCount; a++)
    {
        const Vector3D& n = normal[a];
        const Vector3D& t = tan1[a];
        
        // Gram-Schmidt 직교화
        tangent[a] = (t - n * Dot(n, t)).Normalize();
        
        // 손잡이 계산
        tangent[a].w = (Dot(Cross(n, t), tan2[a]) < 0.0F) ? -1.0F : 1.0F;
    }
    
    delete[] tan1;
}
```
