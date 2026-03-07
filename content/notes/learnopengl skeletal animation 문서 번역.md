---
title: 'learnopengl skeletal animation 문서 번역'
tags:
  - graphics
  - translation
---

_bones dancing_

---

# 스켈레탈 애니메이션

Guest-Articles/2020/Skeletal-Animation

3D 애니메이션은 게임에 생명을 불어넣을 수 있습니다. 인간과 동물과 같은 3D 세계의 오브젝트들은 걷기, 달리기 및 공격과 같은 특정 작업을 수행하기 위해 팔다리를 움직일 때 더욱 유기적으로 느껴집니다.

이 튜토리얼은 여러분 모두가 기다려온 스켈레탈 애니메이션에 관한 것입니다. 우리는 먼저 개념을 철저히 이해한 다음 Assimp를 사용하여 3D 모델을 애니메이션화하는 데 필요한 데이터를 이해할 것입니다. 이 튜토리얼 코드는 이 시리즈의 [Model Loading](https://learnopengl.com/Model-Loading/Assimp) 섹션에서 이어지므로 해당 섹션을 마치는 것을 권장합니다. 그래도 개념을 이해하고 자신만의 방식으로 구현할 수는 있습니다. 그럼 시작해봅시다.

## 보간법 (Interpolation)

애니메이션이 기본 수준에서 어떻게 작동하는지 이해하려면 보간법의 개념을 이해해야 합니다. 보간법은 시간에 걸쳐 무언가가 발생하는 것으로 정의할 수 있습니다. 예를 들어 적이 시간 T동안 점 A에서 점 B로 이동하는 것, 즉 시간에 걸쳐 발생하는 이동(Translation)입니다. 총 포탑이 목표물을 향해 부드럽게 회전하는 것, 즉 시간에 걸쳐 발생하는 회전(Rotation)이고, 나무가 시간 T동안 크기 A에서 크기 B로 크기가 증가하는 것, 즉 시간에 걸쳐 발생하는 스케일링(Scaling)입니다.

이동과 스케일에 사용되는 간단한 보간 방정식은 다음과 같습니다.

```
a = a * (1 - t) + b * t
```

이것은 선형 보간 방정식 또는 Lerp로 알려져 있습니다. 회전의 경우 벡터를 사용할 수 없습니다. 그 이유는 X(Pitch), Y(Yaw) 및 Z(Roll)의 벡터에 선형 보간 방정식을 사용하려고 하면 보간이 선형이 되지 않기 때문입니다. 김벌 락(Gimbal Lock)과 같은 이상한 문제가 발생하게 됩니다(이에 대해 알아보려면 아래 참고 자료 섹션을 참조하십시오). 이 문제를 피하기 위해 회전에는 쿼터니언을 사용합니다. 쿼터니언은 Lerp와 동일한 결과를 제공하지만 두 회전 A와 B에 대한 구면 보간(Spherical Interpolation) 또는 Slerp 방정식이라는 것을 제공합니다. 현재 범위를 벗어나기 때문에 방정식이 어떻게 작동하는지 설명할 수는 없습니다. 쿼터니언을 이해하려면 아래 참고 자료 섹션을 확인하십시오.

## 애니메이션 모델의 구성 요소: 스킨, 본 및 키프레임

애니메이션의 전체 프로세스는 Blender나 Maya와 같은 소프트웨어에서 첫 번째 구성 요소인 스킨(Skin)을 추가하는 것으로 시작됩니다. 스킨은 모델에 시각적 측면을 추가하여 보는 사람에게 어떻게 보이는지 알려주는 메시에 불과합니다. 하지만 메시를 움직이고 싶다면 실제 세계와 마찬가지로 본(Bones)을 추가해야 합니다. Blender와 같은 소프트웨어에서 어떻게 보이는지 이해하려면 아래 이미지를 참조하십시오....

![skin](https://claude.ai/img/guest/2020/skeletal_animation/skin.png) ![bones](https://claude.ai/img/guest/2020/skeletal_animation/bones.png) ![skin and bones](https://claude.ai/img/guest/2020/skeletal_animation/merged.png)

이러한 본은 일반적으로 인간과 동물과 같은 캐릭터에 대해 계층적 방식으로 추가되며 그 이유는 매우 명백합니다. 우리는 팔다리 사이에 부모-자식 관계를 원합니다. 예를 들어, 오른쪽 어깨를 움직이면 오른쪽 상완, 전완, 손과 손가락도 함께 움직여야 합니다. 계층 구조는 다음과 같습니다....

위 다이어그램에서 엉덩이 본을 잡고 움직이면 모든 팔다리가 그 움직임의 영향을 받게 됩니다.

이 시점에서 애니메이션을 위한 키프레임을 만들 준비가 되었습니다. 키프레임은 애니메이션에서 서로 다른 시점의 포즈입니다. 우리는 코드에서 이러한 키프레임 사이를 보간하여 한 포즈에서 다른 포즈로 부드럽게 이동할 것입니다. 아래에서 간단한 4프레임 점프 애니메이션을 위해 포즈가 어떻게 생성되는지 볼 수 있습니다...

## Assimp가 애니메이션 데이터를 보관하는 방법

코드 부분에 거의 도달했지만 먼저 Assimp가 가져온 애니메이션 데이터를 어떻게 보관하는지 이해해야 합니다. 아래 다이어그램을 보십시오..

[Model Loading](https://learnopengl.com/Model-Loading/Assimp) 섹션과 마찬가지로, 루트 노드에 대한 포인터를 보유하는 `aiScene` 포인터부터 시작하여 여기에 애니메이션 배열이 있습니다.

이 `aiAnimation` 배열은 `mDuration`으로 표현되는 애니메이션의 지속 시간과 같은 일반 정보를 포함하며, 그 다음 프레임 간 보간 속도를 제어하는 `mTicksPerSecond` 변수가 있습니다. 마지막 섹션에서 애니메이션에 키프레임이 있다는 것을 기억한다면, 마찬가지로 `aiAnimation`에는 채널(Channels)이라고 하는 `aiNodeAnim` 배열이 포함되어 있습니다.

이 배열에는 애니메이션에 관여할 모든 본과 해당 키프레임이 포함되어 있습니다.

`aiNodeAnim`은 본의 이름을 포함하고 있으며 여기서 보간할 세 가지 유형의 키를 찾을 수 있습니다: 이동(Translation), 회전(Rotation) 및 스케일(Scale).

좋습니다. 이해해야 할 마지막 한 가지가 있고 코드를 작성할 준비가 되었습니다.

## 정점에 대한 여러 본의 영향

우리가 전완을 구부릴 때 우리는 이두근이 불룩 튀어나오는 것을 볼 수 있습니다. 우리는 또한 전완 본 변환이 이두근의 정점에 영향을 미친다고 말할 수 있습니다. 마찬가지로, 메시의 단일 정점에 영향을 미치는 여러 본이 있을 수 있습니다. 단단한 금속 로봇과 같은 캐릭터의 경우 모든 전완 정점은 전완 본에 의해서만 영향을 받지만 인간, 동물 등과 같은 캐릭터의 경우 정점에 영향을 줄 수 있는 최대 4개의 본이 있을 수 있습니다. Assimp가 해당 정보를 어떻게 저장하는지 살펴봅시다...

우리는 모든 `aiMeshes` 배열을 포함하는 `aiScene` 포인터에서 다시 시작합니다.

각 `aiMesh` 객체에는 이 `aiBone`이 메시의 정점 집합에 얼마나 많은 영향을 미칠지에 대한 정보를 포함하는 `aiBone` 배열이 있습니다.

`aiBone`은 본의 이름, 기본적으로 이 `aiBone`이 메시의 어떤 정점에 얼마나 많은 영향을 미칠지 알려주는 `aiVertexWeight` 배열을 포함합니다.

이제 `aiBone`의 한 가지 멤버가 더 있는데 바로 offsetMatrix입니다. 이것은 정점을 모델 공간에서 본 공간으로 변환하는 데 사용되는 4x4 행렬입니다.

아래 이미지에서 이것의 동작을 볼 수 있습니다....

![Mesh Space](https://claude.ai/img/guest/2020/skeletal_animation/mesh_space.png) ![Bone Space](https://claude.ai/img/guest/2020/skeletal_animation/bone_space.png)

정점이 본 공간에 있을 때 그들은 본에 상대적으로 변환될 것입니다. 곧 코드에서 이것의 동작을 보게 될 것입니다.

## 마침내! 코드를 작성해봅시다.

여기까지 와주셔서 감사합니다. 우리는 최종 결과인 최종 버텍스 셰이더 코드를 직접 살펴보는 것으로 시작할 것입니다. 이것은 최종적으로 무엇이 필요한지 잘 알려줄 것입니다..

```glsl
#version 430 core
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 norm;
layout(location = 2) in vec2 tex;
layout(location = 5) in ivec4 boneIds;
layout(location = 6) in vec4 weights;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

const int MAX_BONES = 100;
const int MAX_BONE_INFLUENCE = 4;
uniform mat4 finalBonesMatrices[MAX_BONES];

out vec2 TexCoords;

void main()
{
    vec4 totalPosition = vec4(0.0f);
    for(int i = 0 ; i < MAX_BONE_INFLUENCE ; i++)
    {
        if(boneIds[i] == -1) 
            continue;
        if(boneIds[i] >=MAX_BONES) 
        {
            totalPosition = vec4(pos,1.0f);
            break;
        }
        vec4 localPosition = finalBonesMatrices[boneIds[i]] * vec4(pos,1.0f);
        totalPosition += localPosition * weights[i];
        vec3 localNormal = mat3(finalBonesMatrices[boneIds[i]]) * norm;
    }
    
    mat4 viewModel = view * model;
    gl_Position =  projection * viewModel * totalPosition;
    TexCoords = tex;
}
```

프래그먼트 셰이더는 [이 튜토리얼](https://learnopengl.com/Model-Loading/Model)과 동일하게 유지됩니다.

맨 위부터 시작하면 두 개의 새로운 속성 레이아웃 선언이 보입니다. 첫 번째는 `boneIds`이고 두 번째는 `weights`입니다. 또한 모든 본의 변환을 저장하는 uniform 배열 `finalBonesMatrices`가 있습니다.

`boneIds`는 `finalBonesMatrices` 배열을 읽는 데 사용되는 인덱스를 포함하고 있으며 해당 변환을 `weights` 배열에 저장된 해당 가중치와 함께 `pos` 정점에 적용합니다. 이것은 위의 for 루프 내에서 발생합니다.

이제 먼저 본 가중치에 대한 지원을 `Mesh` 클래스에 추가해봅시다..

```cpp
#define MAX_BONE_INFLUENCE 4

struct Vertex {
    // position
    glm::vec3 Position;
    // normal
    glm::vec3 Normal;
    // texCoords
    glm::vec2 TexCoords;
    // tangent
    glm::vec3 Tangent;
    // bitangent
    glm::vec3 Bitangent;
    //bone indexes which will influence this vertex
    int m_BoneIDs[MAX_BONE_INFLUENCE];
    //weights from each bone
    float m_Weights[MAX_BONE_INFLUENCE];
};
```

버텍스 셰이더에서 본 것처럼 `Vertex`에 두 개의 새로운 속성을 추가했습니다.

이제 `Mesh::setupMesh` 함수에서 다른 속성과 마찬가지로 GPU 버퍼에 로드해봅시다...

```cpp
class Mesh
{
    ...
    void setupMesh()
    {
        ....
        // ids
        glEnableVertexAttribArray(3);
        glVertexAttribIPointer(3, 4, GL_INT, sizeof(Vertex), (void*)offsetof(Vertex, m_BoneIDs));

        // weights
        glEnableVertexAttribArray(4);
        glVertexAttribPointer(4, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), 
                              (void*)offsetof(Vertex, m_Weights));
        ...
    }
    ...
}
```

이전과 동일하지만, 이제 `boneIds`와 `weights`에 대한 레이아웃 위치 ID 3과 4를 추가했습니다. 여기서 주목해야 할 중요한 점은 `boneIds`에 대한 데이터를 전달하는 방법입니다. 우리는 `glVertexAttribIPointer`를 사용하고 세 번째 매개변수로 `GL_INT`를 전달했습니다.

이제 Assimp 데이터 구조에서 본-가중치 정보를 추출할 수 있습니다. Model 클래스에 몇 가지 변경을 해봅시다...

```cpp
struct BoneInfo
{
    /*id is index in finalBoneMatrices*/
    int id;

    /*offset matrix transforms vertex from model space to bone space*/
    glm::mat4 offset;

};
```

이 `BoneInfo`는 오프셋 행렬과 앞서 셰이더에서 본 `finalBoneMatrices` 배열에 저장하는 데 사용될 고유한 ID를 저장합니다.

이제 `Model`에 본 가중치 추출 지원을 추가할 것입니다...

```cpp
class Model 
{
private:
    ...
    std::map<string, BoneInfo> m_BoneInfoMap; //
    int m_BoneCounter = 0;

    auto& GetBoneInfoMap() { return m_BoneInfoMap; }
    int& GetBoneCount() { return m_BoneCounter; }
    ...
    
    void SetVertexBoneDataToDefault(Vertex& vertex)
    {
        for (int i = 0; i < MAX_BONE_WEIGHTS; i++)
        {
            vertex.m_BoneIDs[i] = -1;
            vertex.m_Weights[i] = 0.0f;
        }
    }
    
    Mesh processMesh(aiMesh* mesh, const aiScene* scene)
    {
        vector<Vertex> vertices;
        vector<unsigned int> indices;
        vector<Texture> textures;

        for (unsigned int i = 0; i < mesh->mNumVertices; i++)
        {
            Vertex vertex;
            SetVertexBoneDataToDefault(vertex);
            vertex.Position = AssimpGLMHelpers::GetGLMVec(mesh->mVertices[i]);
            vertex.Normal = AssimpGLMHelpers::GetGLMVec(mesh->mNormals[i]);
            
            if (mesh->mTextureCoords[0])
            {
                glm::vec2 vec;
                vec.x = mesh->mTextureCoords[0][i].x;
                vec.y = mesh->mTextureCoords[0][i].y;
                vertex.TexCoords = vec;
            }
            else
                vertex.TexCoords = glm::vec2(0.0f, 0.0f);

            vertices.push_back(vertex);
        }
        ...
        ExtractBoneWeightForVertices(vertices,mesh,scene);

        return Mesh(vertices, indices, textures);
    }

    void SetVertexBoneData(Vertex& vertex, int boneID, float weight)
    {
        for (int i = 0; i < MAX_BONE_WEIGHTS; ++i)
        {
            if (vertex.m_BoneIDs[i] < 0)
            {
                vertex.m_Weights[i] = weight;
                vertex.m_BoneIDs[i] = boneID;
                break;
            }
        }
    }

    void ExtractBoneWeightForVertices(std::vector<Vertex>& vertices, aiMesh* mesh, const aiScene* scene)
    {
        for (int boneIndex = 0; boneIndex < mesh->mNumBones; ++boneIndex)
        {
            int boneID = -1;
            std::string boneName = mesh->mBones[boneIndex]->mName.C_Str();
            if (m_BoneInfoMap.find(boneName) == m_BoneInfoMap.end())
            {
                BoneInfo newBoneInfo;
                newBoneInfo.id = m_BoneCounter;
                newBoneInfo.offset = AssimpGLMHelpers::ConvertMatrixToGLMFormat(
                                     mesh->mBones[boneIndex]->mOffsetMatrix);
                m_BoneInfoMap[boneName] = newBoneInfo;
                boneID = m_BoneCounter;
                m_BoneCounter++;
            }
            else
            {
                boneID = m_BoneInfoMap[boneName].id;
            }
            assert(boneID != -1);
            auto weights = mesh->mBones[boneIndex]->mWeights;
            int numWeights = mesh->mBones[boneIndex]->mNumWeights;

            for (int weightIndex = 0; weightIndex < numWeights; ++weightIndex)
            {
                int vertexId = weights[weightIndex].mVertexId;
                float weight = weights[weightIndex].mWeight;
                assert(vertexId <= vertices.size());
                SetVertexBoneData(vertices[vertexId], boneID, weight);
            }
        }
    }
    ...
};
```

우리는 맵 `m_BoneInfoMap`과 카운터 `m_BoneCounter`를 선언하는 것으로 시작하며, 이것은 새로운 본을 읽자마자 증가될 것입니다.

앞서 다이어그램에서 본 것처럼 각 `aiMesh`는 `aiMesh`와 연관된 모든 `aiBones`를 포함합니다.

본-가중치 추출의 전체 프로세스는 `processMesh` 함수에서 시작됩니다. 각 루프 반복에서 `SetVertexBoneDataToDefault` 함수를 호출하여 `m_BoneIDs`와 `m_Weights`를 기본값으로 설정하고 있습니다.

`processMesh` 함수가 끝나기 직전에 `ExtractBoneWeightData`를 호출합니다. `ExtractBoneWeightData`에서 각 `aiBone`에 대해 for 루프를 실행하고 이 본이 `m_BoneInfoMap`에 이미 존재하는지 확인합니다.

찾을 수 없다면 새로운 본으로 간주되고 ID로 새 `BoneInfo`를 생성하고 연관된 `mOffsetMatrix`를 저장합니다. 그런 다음 이 새 `BoneInfo`를 `m_BoneInfoMap`에 저장하고 다음 본을 위한 ID를 생성하기 위해 `m_BoneCounter` 카운터를 증가시킵니다. `m_BoneInfoMap`에서 본 이름을 찾은 경우 이 본이 해당 범위를 벗어난 메시의 정점에 영향을 미친다는 것을 의미합니다. 그래서 우리는 해당 ID를 가져와서 어떤 정점에 영향을 미치는지 알기 위해 더 진행합니다.

한 가지 주목할 점은 `AssimpGLMHelpers::ConvertMatrixToGLMFormat`을 호출하고 있다는 것입니다. Assimp는 GLM과 다른 형식으로 행렬 데이터를 저장하므로 이 함수는 GLM 형식의 행렬을 제공합니다.

본에 대한 offsetMatrix를 추출했고 이제 단순히 `aiVertexWeight` 배열을 반복하여 이 본에 의해 영향을 받을 모든 정점 인덱스를 해당 가중치와 함께 추출하고 `SetVertexBoneData`를 호출하여 추출된 정보로 `Vertex.boneIds`와 `Vertex.weights`를 채웁니다.

휴! 이 시점에서 커피 휴식을 가질 자격이 있습니다.

## Bone, Animation 및 Animator 클래스

클래스의 상위 수준 보기는 다음과 같습니다..

우리가 달성하려는 것을 상기시켜봅시다. 각 렌더링 프레임마다 계층 구조의 모든 본을 부드럽게 보간하고 셰이더 uniform `finalBonesMatrices`에 제공될 최종 변환 행렬을 얻으려고 합니다.

각 클래스가 하는 일은 다음과 같습니다...

**Bone**: `aiNodeAnim`에서 모든 키프레임 데이터를 읽는 단일 본입니다. 현재 애니메이션 시간을 기반으로 키, 즉 이동, 스케일 및 회전 사이를 보간할 것입니다.

**AssimpNodeData**: 이 구조체는 애니메이션을 Assimp로부터 격리하는 데 도움이 될 것입니다.

**Animation**: `aiAnimation`에서 데이터를 읽고 `Bone`의 계층적 레코드를 생성하는 자산입니다.

**Animator**: 이것은 `AssimpNodeData`의 계층 구조를 읽고, 재귀적으로 모든 본을 보간한 다음 필요한 최종 본 변환 행렬을 준비합니다.

`Bone`의 코드는 다음과 같습니다...

```cpp
struct KeyPosition
{
    glm::vec3 position;
    float timeStamp;
};

struct KeyRotation
{
    glm::quat orientation;
    float timeStamp;
};

struct KeyScale
{
    glm::vec3 scale;
    float timeStamp;
};

class Bone
{
private:
    std::vector<KeyPosition> m_Positions;
    std::vector<KeyRotation> m_Rotations;
    std::vector<KeyScale> m_Scales;
    int m_NumPositions;
    int m_NumRotations;
    int m_NumScalings;

    glm::mat4 m_LocalTransform;
    std::string m_Name;
    int m_ID;

public:

    /*reads keyframes from aiNodeAnim*/
    Bone(const std::string& name, int ID, const aiNodeAnim* channel)
        :
        m_Name(name),
        m_ID(ID),
        m_LocalTransform(1.0f)
    {
        m_NumPositions = channel->mNumPositionKeys;

        for (int positionIndex = 0; positionIndex < m_NumPositions; ++positionIndex)
        {
            aiVector3D aiPosition = channel->mPositionKeys[positionIndex].mValue;
            float timeStamp = channel->mPositionKeys[positionIndex].mTime;
            KeyPosition data;
            data.position = AssimpGLMHelpers::GetGLMVec(aiPosition);
            data.timeStamp = timeStamp;
            m_Positions.push_back(data);
        }

        m_NumRotations = channel->mNumRotationKeys;
        for (int rotationIndex = 0; rotationIndex < m_NumRotations; ++rotationIndex)
        {
            aiQuaternion aiOrientation = channel->mRotationKeys[rotationIndex].mValue;
            float timeStamp = channel->mRotationKeys[rotationIndex].mTime;
            KeyRotation data;
            data.orientation = AssimpGLMHelpers::GetGLMQuat(aiOrientation);
            data.timeStamp = timeStamp;
            m_Rotations.push_back(data);
        }

        m_NumScalings = channel->mNumScalingKeys;
        for (int keyIndex = 0; keyIndex < m_NumScalings; ++keyIndex)
        {
            aiVector3D scale = channel->mScalingKeys[keyIndex].mValue;
            float timeStamp = channel->mScalingKeys[keyIndex].mTime;
            KeyScale data;
            data.scale = AssimpGLMHelpers::GetGLMVec(scale);
            data.timeStamp = timeStamp;
            m_Scales.push_back(data);
        }
    }

    /*interpolates b/w positions,rotations & scaling keys based on the curren time of 
    the animation and prepares the local transformation matrix by combining all keys 
    tranformations*/
    void Update(float animationTime)
    {
        glm::mat4 translation = InterpolatePosition(animationTime);
        glm::mat4 rotation = InterpolateRotation(animationTime);
        glm::mat4 scale = InterpolateScaling(animationTime);
        m_LocalTransform = translation * rotation * scale;
    }

    glm::mat4 GetLocalTransform() { return m_LocalTransform; }
    std::string GetBoneName() const { return m_Name; }
    int GetBoneID() { return m_ID; }

    
    /* Gets the current index on mKeyPositions to interpolate to based on 
    the current animation time*/
    int GetPositionIndex(float animationTime)
    {
        for (int index = 0; index < m_NumPositions - 1; ++index)
        {
            if (animationTime < m_Positions[index + 1].timeStamp)
                return index;
        }
        assert(0);
    }

    /* Gets the current index on mKeyRotations to interpolate to based on the 
    current animation time*/
    int GetRotationIndex(float animationTime)
    {
        for (int index = 0; index < m_NumRotations - 1; ++index)
        {
            if (animationTime < m_Rotations[index + 1].timeStamp)
                return index;
        }
        assert(0);
    }

    /* Gets the current index on mKeyScalings to interpolate to based on the 
    current animation time */
    int GetScaleIndex(float animationTime)
    {
        for (int index = 0; index < m_NumScalings - 1; ++index)
        {
            if (animationTime < m_Scales[index + 1].timeStamp)
                return index;
        }
        assert(0);
    }

private:

    /* Gets normalized value for Lerp & Slerp*/
    float GetScaleFactor(float lastTimeStamp, float nextTimeStamp, float animationTime)
    {
        float scaleFactor = 0.0f;
        float midWayLength = animationTime - lastTimeStamp;
        float framesDiff = nextTimeStamp - lastTimeStamp;
        scaleFactor = midWayLength / framesDiff;
        return scaleFactor;
    }

    /*figures out which position keys to interpolate b/w and performs the interpolation 
    and returns the translation matrix*/
    glm::mat4 InterpolatePosition(float animationTime)
    {
        if (1 == m_NumPositions)
            return glm::translate(glm::mat4(1.0f), m_Positions[0].position);

        int p0Index = GetPositionIndex(animationTime);
        int p1Index = p0Index + 1;
        float scaleFactor = GetScaleFactor(m_Positions[p0Index].timeStamp,
            m_Positions[p1Index].timeStamp, animationTime);
        glm::vec3 finalPosition = glm::mix(m_Positions[p0Index].position,
            m_Positions[p1Index].position, scaleFactor);
        return glm::translate(glm::mat4(1.0f), finalPosition);
    }

    /*figures out which rotations keys to interpolate b/w and performs the interpolation 
    and returns the rotation matrix*/
    glm::mat4 InterpolateRotation(float animationTime)
    {
        if (1 == m_NumRotations)
        {
            auto rotation = glm::normalize(m_Rotations[0].orientation);
            return glm::toMat4(rotation);
        }

        int p0Index = GetRotationIndex(animationTime);
        int p1Index = p0Index + 1;
        float scaleFactor = GetScaleFactor(m_Rotations[p0Index].timeStamp,
            m_Rotations[p1Index].timeStamp, animationTime);
        glm::quat finalRotation = glm::slerp(m_Rotations[p0Index].orientation,
            m_Rotations[p1Index].orientation, scaleFactor);
        finalRotation = glm::normalize(finalRotation);
        return glm::toMat4(finalRotation);

    }

    /*figures out which scaling keys to interpolate b/w and performs the interpolation 
    and returns the scale matrix*/
    glm::mat4 Bone::InterpolateScaling(float animationTime)
    {
        if (1 == m_NumScalings)
            return glm::scale(glm::mat4(1.0f), m_Scales[0].scale);

        int p0Index = GetScaleIndex(animationTime);
        int p1Index = p0Index + 1;
        float scaleFactor = GetScaleFactor(m_Scales[p0Index].timeStamp,
            m_Scales[p1Index].timeStamp, animationTime);
        glm::vec3 finalScale = glm::mix(m_Scales[p0Index].scale, m_Scales[p1Index].scale
            , scaleFactor);
        return glm::scale(glm::mat4(1.0f), finalScale);
    }

};
```

우리는 키 타입에 대한 3개의 구조체를 생성하는 것으로 시작합니다. 각 구조체는 값과 타임스탬프를 보유합니다. 타임스탬프는 애니메이션의 어느 시점에서 그 값으로 보간해야 하는지 알려줍니다.

`Bone`에는 `aiNodeAnim`에서 읽고 키와 타임스탬프를 `mPositionKeys`, `mRotationKeys` 및 `mScalingKeys`에 저장하는 생성자가 있습니다. 주요 보간 프로세스는 매 프레임 호출되는 `Update(float animationTime)`에서 시작됩니다. 이 함수는 모든 키 타입에 대한 각각의 보간 함수를 호출하고 모든 최종 보간 결과를 결합하여 4x4 행렬 `m_LocalTransform`에 저장합니다. 이동 및 스케일 키에 대한 보간 함수는 유사하지만 회전의 경우 쿼터니언 사이를 보간하기 위해 `Slerp`를 사용하고 있습니다.

`Lerp`와 `Slerp` 모두 3개의 인수를 받습니다. 첫 번째 인수는 마지막 키를 받고, 두 번째 인수는 다음 키를 받고, 세 번째 인수는 0-1 범위의 값을 받으며, 여기서는 스케일 팩터라고 합니다.

`GetScaleFactor` 함수에서 이 스케일 팩터를 어떻게 계산하는지 살펴봅시다...

코드에서...

```cpp
float midWayLength = animationTime - lastTimeStamp;
float framesDiff = nextTimeStamp - lastTimeStamp;
scaleFactor = midWayLength / framesDiff;
```

이제 `Animation` 클래스로 넘어갑시다...

```cpp
struct AssimpNodeData
{
    glm::mat4 transformation;
    std::string name;
    int childrenCount;
    std::vector<AssimpNodeData> children;
};

class Animation
{
public:
    Animation() = default;

    Animation(const std::string& animationPath, Model* model)
    {
        Assimp::Importer importer;
        const aiScene* scene = importer.ReadFile(animationPath, aiProcess_Triangulate);
        assert(scene && scene->mRootNode);
        auto animation = scene->mAnimations[0];
        m_Duration = animation->mDuration;
        m_TicksPerSecond = animation->mTicksPerSecond;
        ReadHeirarchyData(m_RootNode, scene->mRootNode);
        ReadMissingBones(animation, *model);
    }

    ~Animation()
    {
    }

    Bone* FindBone(const std::string& name)
    {
        auto iter = std::find_if(m_Bones.begin(), m_Bones.end(),
            [&](const Bone& Bone)
            {
                return Bone.GetBoneName() == name;
            }
        );
        if (iter == m_Bones.end()) return nullptr;
        else return &(*iter);
    }

    
    inline float GetTicksPerSecond() { return m_TicksPerSecond; }
    inline float GetDuration() { return m_Duration;}
    inline const AssimpNodeData& GetRootNode() { return m_RootNode; }
    inline const std::map<std::string,BoneInfo>& GetBoneIDMap() 
    { 
        return m_BoneInfoMap;
    }

private:
    void ReadMissingBones(const aiAnimation* animation, Model& model)
    {
        int size = animation->mNumChannels;

        auto& boneInfoMap = model.GetBoneInfoMap();//getting m_BoneInfoMap from Model class
        int& boneCount = model.GetBoneCount(); //getting the m_BoneCounter from Model class

        //reading channels(bones engaged in an animation and their keyframes)
        for (int i = 0; i < size; i++)
        {
            auto channel = animation->mChannels[i];
            std::string boneName = channel->mNodeName.data;

            if (boneInfoMap.find(boneName) == boneInfoMap.end())
            {
                boneInfoMap[boneName].id = boneCount;
                boneCount++;
            }
            m_Bones.push_back(Bone(channel->mNodeName.data,
                boneInfoMap[channel->mNodeName.data].id, channel));
        }

        m_BoneInfoMap = boneInfoMap;
    }

    void ReadHeirarchyData(AssimpNodeData& dest, const aiNode* src)
    {
        assert(src);

        dest.name = src->mName.data;
        dest.transformation = AssimpGLMHelpers::ConvertMatrixToGLMFormat(src->mTransformation);
        dest.childrenCount = src->mNumChildren;

        for (int i = 0; i < src->mNumChildren; i++)
        {
            AssimpNodeData newData;
            ReadHeirarchyData(newData, src->mChildren[i]);
            dest.children.push_back(newData);
        }
    }
    float m_Duration;
    int m_TicksPerSecond;
    std::vector<Bone> m_Bones;
    AssimpNodeData m_RootNode;
    std::map<std::string, BoneInfo> m_BoneInfoMap;
};
```

여기서 `Animation` 객체의 생성은 생성자로 시작합니다. 두 개의 인수를 받습니다. 첫째, 애니메이션 파일 경로, 둘째 매개변수는 이 애니메이션을 위한 `Model`입니다.

왜 여기서 이 `Model` 참조가 필요한지는 나중에 볼 수 있습니다. 그런 다음 애니메이션 파일을 읽기 위해 `Assimp::Importer`를 생성하고, 애니메이션을 찾을 수 없으면 오류를 발생시킬 `assert` 확인이 뒤따릅니다. 그런 다음 애니메이션의 길이인 `mDuration`과 `mTicksPerSecond`로 표현되는 애니메이션 속도와 같은 일반 애니메이션 데이터를 읽습니다.

그런 다음 Assimp의 `aiNode` 계층 구조를 복제하고 `AssimpNodeData`의 계층 구조를 생성하는 `ReadHeirarchyData`를 호출합니다.

그런 다음 `ReadMissingBones`라는 함수를 호출합니다. FBX 모델을 별도로 로드할 때 때때로 일부 본이 누락되어 있었고 애니메이션 파일에서 누락된 본을 발견했기 때문에 이 함수를 작성해야 했습니다. 이 함수는 누락된 본 정보를 읽고 `Model`의 `m_BoneInfoMap`에 해당 정보를 저장하고 `m_BoneInfoMap`에 `m_BoneInfoMap` 참조를 로컬로 저장합니다.

그리고 애니메이션이 준비되었습니다. 이제 마지막 단계인 Animator 클래스를 살펴봅시다...

```cpp
class Animator
{
public:
    Animator::Animator(Animation* Animation)
    {
        m_CurrentTime = 0.0;
        m_CurrentAnimation = currentAnimation;

        m_FinalBoneMatrices.reserve(100);

        for (int i = 0; i < 100; i++)
            m_FinalBoneMatrices.push_back(glm::mat4(1.0f));
    }

    void Animator::UpdateAnimation(float dt)
    {
        m_DeltaTime = dt;
        if (m_CurrentAnimation)
        {
            m_CurrentTime += m_CurrentAnimation->GetTicksPerSecond() * dt;
            m_CurrentTime = fmod(m_CurrentTime, m_CurrentAnimation->GetDuration());
            CalculateBoneTransform(&m_CurrentAnimation->GetRootNode(), glm::mat4(1.0f));
        }
    }

    void Animator::PlayAnimation(Animation* pAnimation)
    {
        m_CurrentAnimation = pAnimation;
        m_CurrentTime = 0.0f;
    }

    void Animator::CalculateBoneTransform(const AssimpNodeData* node, glm::mat4 parentTransform)
    {
        std::string nodeName = node->name;
        glm::mat4 nodeTransform = node->transformation;

        Bone* Bone = m_CurrentAnimation->FindBone(nodeName);

        if (Bone)
        {
            Bone->Update(m_CurrentTime);
            nodeTransform = Bone->GetLocalTransform();
        }

        glm::mat4 globalTransformation = parentTransform * nodeTransform;

        auto boneInfoMap = m_CurrentAnimation->GetBoneIDMap();
        if (boneInfoMap.find(nodeName) != boneInfoMap.end())
        {
            int index = boneInfoMap[nodeName].id;
            glm::mat4 offset = boneInfoMap[nodeName].offset;
            m_FinalBoneMatrices[index] = globalTransformation * offset;
        }

        for (int i = 0; i < node->childrenCount; i++)
            CalculateBoneTransform(&node->children[i], globalTransformation);
    }

    std::vector<glm::mat4> GetFinalBoneMatrices() 
    { 
        return m_FinalBoneMatrices; 
    }

private:
    std::vector<glm::mat4> m_FinalBoneMatrices;
    Animation* m_CurrentAnimation;
    float m_CurrentTime;
    float m_DeltaTime;

};
```

`Animator` 생성자는 재생할 애니메이션을 받은 다음 애니메이션 시간 `m_CurrentTime`을 0으로 재설정합니다. 또한 `std::vector<glm::mat4>`인 `m_FinalBoneMatrices`를 초기화합니다.

여기서 주목해야 할 핵심은 `UpdateAnimation(float deltaTime)` 함수입니다. 이것은 `m_TicksPerSecond` 비율로 `m_CurrentTime`을 진행시킨 다음 `CalculateBoneTransform` 함수를 호출합니다.

처음에는 두 개의 인수를 전달할 것입니다. 첫 번째는 `m_CurrentAnimation`의 `m_RootNode`이고 두 번째는 `parentTransform`으로 전달되는 단위 행렬입니다. 이 함수는 `Animation`의 `m_Bones` 배열에서 찾아서 `m_RootNode`의 본이 이 애니메이션에 관여하는지 확인합니다.

본이 발견되면 모든 본을 보간하고 로컬 본 변환 행렬을 `nodeTransform`에 반환하는 `Bone.Update()` 함수를 호출합니다.

하지만 이것은 로컬 공간 행렬이며 셰이더에 전달되면 본을 원점 주위로 이동시킬 것입니다. 그래서 우리는 이 `nodeTransform`을 `parentTransform`과 곱하고 결과를 `globalTransformation`에 저장합니다. 이것만으로도 충분하지만 정점은 여전히 기본 모델 공간에 있습니다. `m_BoneInfoMap`에서 오프셋 행렬을 찾아 `globalTransfromMatrix`와 곱합니다.

또한 이 본의 최종 변환을 `m_FinalBoneMatrices`에 작성하는 데 사용될 id 인덱스를 가져옵니다. 마지막으로! 우리는 이 노드의 각 자식 노드에 대해 `CalculateBoneTransform`을 호출하고 `globalTransformation`을 `parentTransform`으로 전달합니다.

더 이상 처리할 자식이 없으면 이 재귀 루프를 중단합니다.

## 애니메이션하기

우리 노고의 결실이 마침내 여기 있습니다! main.cpp에서 애니메이션을 재생하는 방법은 다음과 같습니다...

```cpp
int main()
{
    ...
    Model ourModel(FileSystem::getPath("resources/objects/vampire/dancing_vampire.dae"));
    Animation danceAnimation(FileSystem::getPath("resources/objects/vampire/dancing_vampire.dae"),
                                &ourModel);
    Animator animator(&danceAnimation);

    // draw in wireframe
    //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    // render loop
    // -----------
    while (!glfwWindowShouldClose(window))
    {
        // per-frame time logic
        // --------------------
        float currentFrame = glfwGetTime();
        deltaTime = currentFrame - lastFrame;
        lastFrame = currentFrame;

        // input
        // -----
        processInput(window);
        animator.UpdateAnimation(deltaTime);

        // render
        // ------
        glClearColor(0.05f, 0.05f, 0.05f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // don't forget to enable shader before setting uniforms
        ourShader.use();

        // view/projection transformations
        glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom),
            (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
        glm::mat4 view = camera.GetViewMatrix();
        ourShader.setMat4("projection", projection);
        ourShader.setMat4("view", view);

        auto transforms = animator.GetFinalBoneMatrices();
        for (int i = 0; i < transforms.size(); ++i)
            ourShader.setMat4("finalBonesMatrices[" + std::to_string(i) + "]", transforms[i]);

        // render the loaded model
        glm::mat4 model = glm::mat4(1.0f);
        model = glm::translate(model, glm::vec3(0.0f, -0.4f, 0.0f)); // translate it down so it's at the center of the scene
        model = glm::scale(model, glm::vec3(.5f, .5f, .5f));	// it's a bit too big for our scene, so scale it down
        ourShader.setMat4("model", model);
        ourModel.Draw(ourShader);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // glfw: terminate, clearing all previously allocated GLFW resources.
    // ------------------------------------------------------------------
    glfwTerminate();
    return 0;
```

우리는 셰이더에 대한 본 가중치 데이터를 설정할 `Model`을 로드하는 것으로 시작하여 경로를 제공하여 `Animation`을 생성합니다. 그런 다음 생성된 `Animation`을 전달하여 `Animator` 객체를 생성합니다. 렌더 루프에서 `Animator`를 업데이트하고 최종 본 변환을 가져와 셰이더에 제공합니다. 여기 우리 모두가 기다려온 결과물이 있습니다...

![output](https://claude.ai/img/guest/2020/skeletal_animation/output.gif)

[여기](https://learnopengl.com/Model-Loading/Assimp)에서 사용된 모델을 다운로드하십시오. 애니메이션과 메시는 단일 DAE(collada) 파일에 구워져 있습니다. 이 데모의 전체 소스 코드는 [여기](https://claude.ai/code_viewer_gh.php?code=src/8.guest/2020/skeletal_animation/skeletal_animation.cpp)에서 찾을 수 있습니다.

## 추가 읽을거리

[Quaternions](http://www.songho.ca/math/quaternion/quaternion.html): 쿼터니언을 깊이 이해하기 위한 songho의 문서.  
[Skeletal Animation with Assimp](http://ogldev.atspace.co.uk/www/tutorial38/tutorial38.html): OGL Dev의 문서.  
[Skeletal Animation with Java](https://youtu.be/f3Cr8Yx3GGA): Thin Matrix의 환상적인 YouTube 재생 목록.  
[Why Quaternions should be used for Rotation](https://www.gamasutra.com/view/feature/131686/rotating_objects_using_quaternions.php): 멋진 gamasutra 문서.

연락처:

